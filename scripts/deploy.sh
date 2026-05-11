#!/usr/bin/env bash
#
# deploy.sh — stage one project's build outputs to one rig.
#
# Invocation (from Makefile):
#   deploy.sh <project> <mode> <arch> <target> <build-root>
#
#   project    rcbot | metamod-r | amxmodx | halflife-updated | rehlds
#   mode       local | remote      (remote: rsync over ssh)
#   arch       i386 | amd64 | aarch64
#   target     local path, OR for remote: host:path
#   build-root project's source dir (build_<arch>/ or build-<arch>/ lives here)
#
# Idempotent. Also sets up rig plumbing (valve/addons/ skeleton,
# metamod plugins.ini, liblist.gam gamedll_linux) on every invocation
# so any project's deploy works even on a fresh rig.

set -euo pipefail

if [[ $# -lt 5 ]]; then
    echo "usage: $0 <project> <mode> <arch> <target> <build-root>" >&2
    exit 2
fi

PROJECT="$1"
MODE="$2"
ARCH="$3"
TARGET="$4"
SRC="$5"

case "$ARCH" in
    i386)    RCBOT_ABI=linux-x86 ;;
    amd64)   RCBOT_ABI=linux-x86_64 ;;
    aarch64) RCBOT_ABI=linux-arm64 ;;
    *) echo "deploy.sh: bad arch '$ARCH'" >&2; exit 2 ;;
esac

# A staging dir we can rsync from when mode=remote (so we can do all
# the local file shuffling without ssh round-trips per file).
STAGE="$(mktemp -d)"
trap 'rm -rf "$STAGE"' EXIT

# --- helpers --------------------------------------------------------

# stage_path() returns the local filesystem path to use for this
# deploy. For local mode that's $TARGET directly; for remote it's
# a temp staging dir we sync at the end.
stage_path() {
    if [[ "$MODE" == "local" ]]; then echo "$TARGET"
    else                                echo "$STAGE"
    fi
}

# ensure_dir <local-path>  — creates a dir under the staging root.
ensure_dir() {
    mkdir -p "$(stage_path)/$1"
}

# stage_file <src> <rel-dest>  — copies src into the staging root at
# rel-dest (path under target's root, e.g. "valve/dlls/hl.so").
stage_file() {
    local src="$1" rel="$2"
    if [[ ! -e "$src" ]]; then
        echo "deploy.sh: missing source: $src" >&2
        return 1
    fi
    ensure_dir "$(dirname "$rel")"
    cp -af "$src" "$(stage_path)/$rel"
    echo "  $rel"
}

# stage_tree <src-dir> <rel-dest-dir>  — rsyncs a directory tree.
stage_tree() {
    local src="$1" rel="$2"
    if [[ ! -d "$src" ]]; then
        echo "deploy.sh: missing source tree: $src" >&2
        return 1
    fi
    ensure_dir "$rel"
    rsync -a "$src/" "$(stage_path)/$rel/"
    echo "  $rel/ (tree)"
}

# ensure_plumbing — idempotent rig setup: addons skeleton, metamod
# plugins.ini, liblist.gam gamedll_linux pointing at metamod_<arch>.
# Runs on every deploy invocation; cheap and safe.
ensure_plumbing() {
    local root
    root="$(stage_path)"

    # If this is a remote deploy we don't have the existing rig state
    # locally — skip the plumbing-edit step for now; pleb is assumed
    # already wired (or wire by hand once). For local rigs, edit in-place.
    if [[ "$MODE" == "remote" ]]; then
        return 0
    fi

    mkdir -p "$root/valve/addons/metamod/dlls" \
             "$root/valve/addons/amxmodx/dlls" \
             "$root/valve/addons/rcbot" \
             "$root/valve/dlls"

    # plugins.ini: list the two plugins for this arch. Overwrites the
    # existing file so the arch suffix stays consistent with the rig.
    cat > "$root/valve/addons/metamod/plugins.ini" <<EOF
linux addons/amxmodx/dlls/amxmodx_mm_${ARCH}.so
linux addons/metamod/dlls/rcbot_mm_${ARCH}.so
EOF

    # config.ini: metamod's own config — gamedll points at the real
    # halflife gamedll under valve/dlls/hl.so. Only write if absent
    # so a user's customizations survive.
    if [[ ! -f "$root/valve/addons/metamod/config.ini" ]]; then
        cat > "$root/valve/addons/metamod/config.ini" <<EOF
; Metamod-R config.ini
gamedll dlls/hl.so
EOF
    fi

    # liblist.gam: ensure gamedll_linux points at the metamod .so for
    # this arch. Edit in place; preserve other keys verbatim.
    local lib="$root/valve/liblist.gam"
    if [[ -f "$lib" ]]; then
        if grep -q '^gamedll_linux ' "$lib"; then
            sed -i "s|^gamedll_linux .*|gamedll_linux \"addons/metamod/dlls/metamod_${ARCH}.so\"|" "$lib"
        else
            printf 'gamedll_linux "addons/metamod/dlls/metamod_%s.so"\n' "$ARCH" >> "$lib"
        fi
    fi
}

# --- per-project copy logic ----------------------------------------

deploy_rcbot() {
    stage_file \
        "$SRC/build_${ARCH}/rcbot_mm_${ARCH}/${RCBOT_ABI}/rcbot_mm_${ARCH}.so" \
        "valve/addons/metamod/dlls/rcbot_mm_${ARCH}.so"
    # Ship the rcbot config tree if it's there. Don't overwrite
    # waypoints (per-server tunable).
    if [[ -d "$SRC/rcbot" ]]; then
        rsync -a --exclude='waypoints/' "$SRC/rcbot/" \
            "$(stage_path)/valve/addons/rcbot/"
        echo "  valve/addons/rcbot/ (config tree)"
    fi
}

deploy_metamod_r() {
    stage_file \
        "$SRC/build-${ARCH}/metamod/metamod_${ARCH}.so" \
        "valve/addons/metamod/dlls/metamod_${ARCH}.so"
}

deploy_amxmodx() {
    # The build/packages/base/addons/amxmodx tree is the deploy-ready
    # layout for the HL/valve game (configs, modules, plugins,
    # scripting, dlls/amxmodx_mm_<arch>.so).
    #
    # TODO(follow-up): also stage the per-game amxmodx packages —
    # packages/{cstrike,dod,esf,ns,tfc,ts}/addons/amxmodx — into the
    # matching game dirs when they exist on the rig. The current
    # rigs use nodemod (not amxmodx) on cstrike/, so the gap doesn't
    # bite today, but multi-game rigs (e.g. arm64 has ts/) would
    # benefit from full coverage. ~20 lines; tracked separately.
    local pkg="$SRC/build_${ARCH}/packages/base/addons/amxmodx"
    if [[ -d "$pkg" ]]; then
        stage_tree "$pkg" "valve/addons/amxmodx"
    fi
    # The core .so might not be inside packages/base — make sure it's
    # in dlls/ even if the base tree didn't include it.
    local core="$SRC/build_${ARCH}/amxmodx/amxmodx_mm_${ARCH}/amxmodx_mm_${ARCH}.so"
    if [[ -f "$core" ]]; then
        stage_file "$core" "valve/addons/amxmodx/dlls/amxmodx_mm_${ARCH}.so"
    fi
}

deploy_halflife_updated() {
    stage_file \
        "$SRC/build-${ARCH}/dlls/hl.so" \
        "valve/dlls/hl.so"
}

deploy_rehlds() {
    # Per-arch lib subdir name (matches the buildchain's ARCH_LIB_DIR).
    local libdir
    case "$ARCH" in
        i386)    libdir=linux32 ;;
        amd64)   libdir=linux64 ;;
        aarch64) libdir=linuxarm64 ;;
    esac

    local bd="$SRC/build-${ARCH}/rehlds"
    stage_file "$bd/engine_i486.so"                               "engine_i486.so"
    stage_file "$bd/dedicated/hlds_linux"                         "hlds_linux"
    stage_file "$bd/filesystem/FileSystem_Stdio/filesystem_stdio.so" "filesystem_stdio.so"
    stage_file "$bd/HLTV/Proxy/proxy.so"                          "proxy.so"
    stage_file "$bd/HLTV/DemoPlayer/demoplayer.so"                "demoplayer.so"
    stage_file "$bd/HLTV/Core/core.so"                            "core.so"
    # HLTV components shipped with the engine — director is the
    # per-game gamedll piece, lives under valve/dlls/ in deployed form.
    if [[ -f "$bd/HLTV/Director/director.so" ]]; then
        stage_file "$bd/HLTV/Director/director.so" "valve/dlls/director.so"
    fi
    # The from-source v1.60 libsteam_api shim, output under
    # rehlds/lib/<libdir>/ — single source per-arch.
    if [[ -f "$SRC/rehlds/lib/${libdir}/libsteam_api.so" ]]; then
        stage_file "$SRC/rehlds/lib/${libdir}/libsteam_api.so" "libsteam_api.so"
    fi
    # hltv console binary
    if [[ -f "$bd/HLTV/Console/hltv" ]]; then
        stage_file "$bd/HLTV/Console/hltv" "hltv"
    fi
}

# --- main -----------------------------------------------------------

echo ">>> deploy $PROJECT → $TARGET ($ARCH, $MODE)"

ensure_plumbing

case "$PROJECT" in
    rcbot)            deploy_rcbot ;;
    metamod-r)        deploy_metamod_r ;;
    amxmodx)          deploy_amxmodx ;;
    halflife-updated) deploy_halflife_updated ;;
    rehlds)           deploy_rehlds ;;
    *) echo "deploy.sh: unknown project '$PROJECT'" >&2; exit 2 ;;
esac

# For remote mode, sync the staged tree up to the remote rig. ssh-key
# auth assumed; --update keeps newer-on-remote files (in case the
# remote has timestamp metadata we shouldn't clobber).
if [[ "$MODE" == "remote" ]]; then
    rsync -avzh --progress "$STAGE/" "$TARGET/"
fi
