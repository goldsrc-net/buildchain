#!/usr/bin/env bash
#
# build-dropins.sh — compose per-arch HLDS drop-in zips from the
# per-consumer release artifacts in release-assets/.
#
# Reads:  release-assets/{amxmodx,halflife-updated,metamod-r,rcbotold,rehlds}
#                       -{linux,windows}-{i386,amd64,aarch64}.zip
# Writes: release-dropins/hlds-dropin-{linux,windows}-<arch>.zip
#
# Used both locally and from the buildchain's release-dropins workflow.
# Assumes release-assets/ is already populated (run fetch-release-artifacts.sh
# first if not).

set -euo pipefail

SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
REPO_ROOT=$(cd "$SCRIPT_DIR/.." && pwd)
IN_DIR=${IN_DIR:-$REPO_ROOT/release-assets}
OUT_DIR=${OUT_DIR:-$REPO_ROOT/release-dropins}
# Cache for upstream Steam-client packages fetched per release.  Content-
# addressed (sha1-in-filename), so refetches are idempotent and old
# revisions remain valid pinned URLs.
VALVE_CACHE=${VALVE_CACHE:-$REPO_ROOT/release-cache/valve}

mkdir -p "$OUT_DIR" "$VALVE_CACHE"

TMP_ROOT=$(mktemp -d -t build-dropins.XXXXXX)
trap 'rm -rf "$TMP_ROOT"' EXIT

# Pinned Steam-client package URLs per arch.  URLs are content-addressed
# at the CDN — pin a fresh one per release if you want a newer Steam
# revision.  Reproduce the URL list locally via
# `python3 ~/Containers/hlds/steamcdn.py <channel> --role client --platform <p>`.
# Files to extract are relative to the zip root.
#
# arch_key  url  files...
valve_pins=(
  "linux-aarch64 https://client-update.steamstatic.com/bins_linuxarm64_linuxarm64.zip.a7395e0a879162bb09ff710dada51e02b24129ee steamrtarm64/steamclient.so steamrtarm64/libtier0_s.so steamrtarm64/libvstdlib_s.so"
)

# (os, arch, rehlds_libdir, ext, plugins_ini_platform_tag, steam_api_basename)
# plugins_ini_platform_tag: Metamod-R reads `linux` and `win32` as platform
# selectors; `win32` matches both 32- and 64-bit Windows runtime.
arches=(
  "linux   i386    linux32    so   linux  libsteam_api.so"
  "linux   amd64   linux64    so   linux  libsteam_api.so"
  "linux   aarch64 linuxarm64 so   linux  libsteam_api.so"
  "windows i386    win32      dll  win32  steam_api.dll"
  "windows amd64   win64      dll  win32  steam_api64.dll"
)

amxmodx_pkgs=(base cstrike dod esf ns tfc ts)

# --- per-arch helpers ----------------------------------------------------

stage_rehlds() {
  local stage="$1" os="$2" arch="$3" libdir="$4"
  local zip="$IN_DIR/rehlds-${os}-${arch}.zip"
  [ -f "$zip" ] || { echo "::error::missing $zip"; return 1; }

  local tmp="$TMP_ROOT/rehlds-${os}-${arch}"
  rm -rf "$tmp" && mkdir -p "$tmp"
  # Engine + HLTV binaries live under bin/<libdir>/; debug/, hlsdk/ skipped.
  unzip -q "$zip" "bin/$libdir/*" -d "$tmp"

  # Promote bin/<libdir>/* to the dropin root; valve/dlls/director.{so,dll}
  # rides along (it lives at bin/<libdir>/valve/dlls/ inside the zip).
  cp -a "$tmp/bin/$libdir/." "$stage/"
}

stage_halflife() {
  local stage="$1" os="$2" arch="$3" ext="$4"
  local zip="$IN_DIR/halflife-updated-${os}-${arch}.zip"
  [ -f "$zip" ] || { echo "::error::missing $zip"; return 1; }

  local tmp="$TMP_ROOT/hl-${os}-${arch}"
  rm -rf "$tmp" && mkdir -p "$tmp"
  unzip -q "$zip" -d "$tmp"

  mkdir -p "$stage/valve/dlls"
  # The halflife-updated zips have three shapes — i386 ships at zip root
  # (alongside client.so + .dbg files; only i386 builds a client lib),
  # other Linux arches use dlls/, Windows i386 uses hldll/ + hl_cdll/.
  # We pick the server gamedll only.
  if [ -f "$tmp/dlls/hl.${ext}" ]; then
    cp "$tmp/dlls/hl.${ext}" "$stage/valve/dlls/hl.${ext}"
  elif [ -f "$tmp/hldll/hl.dll" ]; then
    cp "$tmp/hldll/hl.dll" "$stage/valve/dlls/hl.dll"
  elif [ -f "$tmp/hl.${ext}" ]; then
    cp "$tmp/hl.${ext}" "$stage/valve/dlls/hl.${ext}"
  else
    echo "::error::no hl gamedll in $zip"; return 1
  fi
}

stage_metamod() {
  local stage="$1" os="$2" arch="$3" ext="$4"
  local zip="$IN_DIR/metamod-r-${os}-${arch}.zip"
  [ -f "$zip" ] || { echo "::error::missing $zip"; return 1; }

  local tmp="$TMP_ROOT/mm-${os}-${arch}"
  rm -rf "$tmp" && mkdir -p "$tmp"
  # Only addons/metamod/; skip example_plugin/, appversion.h.
  unzip -q "$zip" "addons/metamod/*" -d "$tmp"

  mkdir -p "$stage/valve/addons/metamod/dlls"
  cp "$tmp/addons/metamod/config.ini" "$stage/valve/addons/metamod/config.ini"
  # Metamod-R's zip places the .so/.dll at addons/metamod/; we relocate to
  # addons/metamod/dlls/ to match the deploy.sh-canonical layout the test
  # rigs use.  The upstream plugins.ini is a stub (all comments) so we drop
  # it in favour of the generated one written below.
  cp "$tmp/addons/metamod/metamod_${arch}.${ext}" \
     "$stage/valve/addons/metamod/dlls/metamod_${arch}.${ext}"
}

stage_rcbot() {
  local stage="$1" os="$2" arch="$3" ext="$4"
  local zip="$IN_DIR/rcbotold-${os}-${arch}.zip"
  [ -f "$zip" ] || { echo "::error::missing $zip"; return 1; }

  local tmp="$TMP_ROOT/rc-${os}-${arch}"
  rm -rf "$tmp" && mkdir -p "$tmp"
  unzip -q "$zip" -d "$tmp"

  mkdir -p "$stage/valve/addons"
  cp -a "$tmp/rcbot" "$stage/valve/addons/rcbot"
  cp "$tmp/dlls/rcbot_mm_${arch}.${ext}" \
     "$stage/valve/addons/metamod/dlls/rcbot_mm_${arch}.${ext}"
}

stage_amxmodx() {
  local stage="$1" os="$2" arch="$3"
  local zip="$IN_DIR/amxmodx-${os}-${arch}.zip"
  [ -f "$zip" ] || { echo "::error::missing $zip"; return 1; }

  local tmp="$TMP_ROOT/ax-${os}-${arch}"
  rm -rf "$tmp" && mkdir -p "$tmp"
  unzip -q "$zip" -d "$tmp"

  # Each of the 7 per-game inner archives extracts into its own gamedir.
  # The inner tree is rooted at addons/amxmodx/, so prefixing with $gamedir
  # gives the canonical <gamedir>/addons/amxmodx/ layout.
  local pkg game found inner
  for pkg in "${amxmodx_pkgs[@]}"; do
    game="$pkg"
    [ "$pkg" = "base" ] && game="valve"
    mkdir -p "$stage/$game"
    found=
    for inner in "$tmp/amxmodx-"*"-${pkg}-${os}-${arch}".tar.gz \
                 "$tmp/amxmodx-"*"-${pkg}-${os}-${arch}".zip; do
      [ -f "$inner" ] || continue
      found=1
      case "$inner" in
        *.tar.gz) tar xzf "$inner" -C "$stage/$game/" ;;
        *.zip)    unzip -q -o "$inner" -d "$stage/$game/" ;;
      esac
      break
    done
    [ -n "$found" ] || echo "::warning::amxmodx pkg '$pkg' missing for $os-$arch (skipped)"
  done
}

stage_valve_libs() {
  local stage="$1" os="$2" arch="$3"
  local key="${os}-${arch}" pin found= url= file
  local -a files=()

  for pin in "${valve_pins[@]}"; do
    # shellcheck disable=SC2086
    set -- $pin
    [ "$1" = "$key" ] || continue
    url="$2"
    shift 2
    files=("$@")
    found=1
    break
  done
  [ -n "$found" ] || return 0   # no pin for this arch — skip silently

  # Content-addressed cache filename: <basename>.<sha1>.zip
  # (matches steamcdn.py's _local_name() convention).
  local cdn_base="${url##*/}"
  local cache_name
  case "$cdn_base" in
    *.zip.*) cache_name="${cdn_base%.zip.*}.${cdn_base##*.zip.}.zip" ;;
    *)       cache_name="$cdn_base" ;;
  esac
  local cache="$VALVE_CACHE/$cache_name"

  if [ ! -s "$cache" ]; then
    echo "  fetching valve libs: $url"
    curl -fsSL "$url" -o "$cache.tmp"
    mv "$cache.tmp" "$cache"
  else
    echo "  cache hit: $cache_name"
  fi

  for file in "${files[@]}"; do
    local basename="${file##*/}"
    unzip -p "$cache" "$file" > "$stage/$basename"
    [ -s "$stage/$basename" ] || { echo "::error::empty extract: $file"; return 1; }
  done
}

write_plugins_ini() {
  local stage="$1" arch="$2" ext="$3" platform="$4"
  cat > "$stage/valve/addons/metamod/plugins.ini" <<EOF
$platform addons/amxmodx/dlls/amxmodx_mm_${arch}.${ext}
$platform addons/metamod/dlls/rcbot_mm_${arch}.${ext}
EOF
}

write_apply_liblist_sh() {
  local stage="$1" arch="$2"
  cat > "$stage/apply-liblist.sh" <<EOF
#!/usr/bin/env bash
# apply-liblist.sh — point valve/liblist.gam at metamod-r as the gamedll.
# Run from your HLDS install dir.  Idempotent.
set -euo pipefail
lib="\${1:-valve/liblist.gam}"
val='addons/metamod/dlls/metamod_${arch}.so'
if [ ! -f "\$lib" ]; then
  echo "error: \$lib not found.  Run from your HLDS install dir."
  exit 1
fi
if grep -q '^gamedll_linux ' "\$lib"; then
  sed -i.bak "s|^gamedll_linux .*|gamedll_linux \"\$val\"|" "\$lib"
else
  printf 'gamedll_linux "%s"\n' "\$val" >> "\$lib"
fi
echo "set gamedll_linux \"\$val\" in \$lib"
EOF
  chmod +x "$stage/apply-liblist.sh"
}

write_apply_liblist_bat() {
  local stage="$1" arch="$2"
  # %VAL% baked at write time with the per-arch suffix.
  cat > "$stage/apply-liblist.bat" <<EOF
@echo off
REM apply-liblist.bat — point valve\\liblist.gam at metamod-r as the gamedll.
REM Run from your HLDS install dir.
setlocal enabledelayedexpansion
set "LIB=valve\\liblist.gam"
set "VAL=addons/metamod/dlls/metamod_${arch}.dll"
if not exist "%LIB%" (
  echo error: %LIB% not found.  Run from your HLDS install dir.
  exit /b 1
)
findstr /B "gamedll " "%LIB%" >nul
if errorlevel 1 (
  >> "%LIB%" echo gamedll "%VAL%"
) else (
  set "TMP=%LIB%.new"
  > "!TMP!" (
    for /f "usebackq delims=" %%L in ("%LIB%") do (
      set "L=%%L"
      if /i "!L:~0,8!"=="gamedll " (
        echo gamedll "%VAL%"
      ) else (
        echo !L!
      )
    )
  )
  move /Y "!TMP!" "%LIB%" >nul
)
echo set gamedll "%VAL%" in %LIB%
EOF
}

write_readme() {
  local stage="$1" os="$2" arch="$3" ext="$4"
  local lib_key="gamedll_linux"
  local apply_cmd="./apply-liblist.sh"
  if [ "$os" = "windows" ]; then
    lib_key="gamedll"
    apply_cmd="apply-liblist.bat"
  fi
  cat > "$stage/README-dropin.md" <<EOF
# hlds-dropin-${os}-${arch}

Drop-in overlay for a HLDS / ReHLDS dedicated server, preconfigured with
Metamod-R + amxmodx + rcbot + halflife-updated for the **${os}/${arch}** target.

Produced by the goldsrc-net/buildchain release pipeline.

## What this contains

- **ReHLDS engine + HLTV** binaries at the dropin root (engine,
  hlds launcher, hltv, filesystem_stdio, core, demoplayer, proxy,
  libsteam_api / steam_api).
- **halflife-updated** gamedll (\`valve/dlls/hl.${ext}\`).
- **Metamod-R** (\`valve/addons/metamod/dlls/metamod_${arch}.${ext}\`) plus
  its \`config.ini\` template.
- **rcbot** plugin (\`valve/addons/metamod/dlls/rcbot_mm_${arch}.${ext}\`)
  and the upstream rcbot data tree (\`valve/addons/rcbot/\`).
- **amxmodx** core + 6 per-mod packages: \`valve/addons/amxmodx/\` (base)
  and \`cstrike/\`, \`dod/\`, \`esf/\`, \`ns/\`, \`tfc/\`, \`ts/\` addons trees.

## What this does NOT contain (and why)

Half-Life game data (maps, sprites, sounds, \`valve/*.wad\`) and the
bulk of the Valve-supplied client libraries (\`vgui*\`, \`voice_*\`,
\`hlds_run\`, ...) come from the base HLDS install.  Install them once via:

\`\`\`
steamcmd +force_install_dir <your-hlds-dir> +login anonymous +app_update 90 validate +quit
\`\`\`

then extract this drop-in over the same directory.

## How to apply

1. Make sure you have a HLDS install at, say, \`~/hlds/\` (per above).
2. Extract this zip into that directory.  Overwrite conflicts intentionally:
   ReHLDS replaces the stock engine, \`valve/dlls/hl.${ext}\` replaces the
   stock Half-Life gamedll, etc.
3. Wire metamod-r into \`valve/liblist.gam\`:
   \`\`\`
   ${apply_cmd}
   \`\`\`
   (or set \`${lib_key} "addons/metamod/dlls/metamod_${arch}.${ext}"\` by hand).
4. Start the server.

## Configuration entrypoints

- \`valve/addons/metamod/plugins.ini\` — list of plugins Metamod-R loads.
  Two are wired: amxmodx and rcbot.  Comment out either to disable.
- \`valve/addons/metamod/config.ini\` — Metamod-R debug level / exec_cfg / etc.
- \`valve/addons/amxmodx/configs/\` — amxmodx core (users.ini, plugins.ini,
  amxx.cfg, ...).
- \`valve/addons/rcbot/\` — rcbot data: \`bots.txt\`, \`botprofiles.db\`,
  \`waypoints/\`, \`map_configs/\`.

For per-mod amxmodx config (cstrike, dod, ns, tfc, ts, esf), see the
matching \`<mod>/addons/amxmodx/\` tree shipped alongside.
EOF
}

# --- main ---------------------------------------------------------------

build_one() {
  local os="$1" arch="$2" libdir="$3" ext="$4" platform="$5" steam_api="$6"
  local stem="hlds-dropin-${os}-${arch}"
  local stage="$TMP_ROOT/$stem"
  rm -rf "$stage" && mkdir -p "$stage"

  echo "==== $stem ===="
  stage_rehlds    "$stage" "$os" "$arch" "$libdir"
  stage_halflife  "$stage" "$os" "$arch" "$ext"
  stage_metamod   "$stage" "$os" "$arch" "$ext"
  stage_rcbot     "$stage" "$os" "$arch" "$ext"
  stage_amxmodx   "$stage" "$os" "$arch"
  stage_valve_libs "$stage" "$os" "$arch"
  write_plugins_ini "$stage" "$arch" "$ext" "$platform"
  if [ "$os" = "linux" ]; then
    write_apply_liblist_sh "$stage" "$arch"
  else
    write_apply_liblist_bat "$stage" "$arch"
  fi
  write_readme "$stage" "$os" "$arch" "$ext"

  rm -f "$OUT_DIR/$stem.zip"
  ( cd "$stage" && zip -qr "$OUT_DIR/$stem.zip" . )
  echo "  -> $OUT_DIR/$stem.zip ($(du -h "$OUT_DIR/$stem.zip" | cut -f1))"
}

for spec in "${arches[@]}"; do
  # shellcheck disable=SC2086
  set -- $spec
  build_one "$1" "$2" "$3" "$4" "$5" "$6"
done

echo
echo "Done. Drop-in zips in $OUT_DIR/ ($(ls -1 "$OUT_DIR" | wc -l) files):"
ls -lah "$OUT_DIR/"
