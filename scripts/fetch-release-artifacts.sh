#!/usr/bin/env bash
#
# fetch-release-artifacts.sh — download each consumer-repo's CI artifacts
# for the currently-pinned SHA and rename them to the buildchain-uniform
# `<consumer>-<os>-<arch>.zip` scheme.  Writes to release-assets/ by default.
#
# Used both locally and from the buildchain's release workflow.  Auth via
# the `gh` CLI's existing credentials locally, or GITHUB_TOKEN in CI.

set -euo pipefail

OUT_DIR=${OUT_DIR:-release-assets}
mkdir -p "$OUT_DIR"

# Per-consumer mapping functions.  Each takes a source artifact name and
# echoes the target asset basename (no .zip suffix), or stays silent to
# skip the artifact.

map_amxmodx() {
  case "$1" in
    amxmodx-linux-i386)    echo amxmodx-linux-i386 ;;
    amxmodx-linux-amd64)   echo amxmodx-linux-amd64 ;;
    amxmodx-linux-aarch64) echo amxmodx-linux-aarch64 ;;
    amxmodx-windows-i386)  echo amxmodx-windows-i386 ;;
    amxmodx-windows-amd64) echo amxmodx-windows-amd64 ;;
  esac
}

map_rcbotold() {
  # Strip a trailing 7-hex-char SHA suffix that the rcbot CI bakes in.
  local base
  base=$(echo "$1" | sed -E 's/-[0-9a-f]{7}$//')
  case "$base" in
    rcbot-linux-i386)    echo rcbotold-linux-i386 ;;
    rcbot-linux-amd64)   echo rcbotold-linux-amd64 ;;
    rcbot-linux-aarch64) echo rcbotold-linux-aarch64 ;;
    rcbot-win32-i386)    echo rcbotold-windows-i386 ;;
    rcbot-win64-amd64)   echo rcbotold-windows-amd64 ;;
    # rcbot-dbgsym-*: skipped (debug symbols not shipped in releases)
  esac
}

map_metamod_r() {
  case "$1" in
    linux32)    echo metamod-r-linux-i386 ;;
    linux64)    echo metamod-r-linux-amd64 ;;
    linuxarm64) echo metamod-r-linux-aarch64 ;;
    win32)      echo metamod-r-windows-i386 ;;
    win64)      echo metamod-r-windows-amd64 ;;
  esac
}

map_halflife_updated() {
  case "$1" in
    Linux-i386-g++) echo halflife-updated-linux-i386 ;;  # gcc canonical; clang variant skipped
    Linux-amd64)    echo halflife-updated-linux-amd64 ;;
    Linux-aarch64)  echo halflife-updated-linux-aarch64 ;;
    Win32)          echo halflife-updated-windows-i386 ;;
    Win64)          echo halflife-updated-windows-amd64 ;;
  esac
}

map_rehlds() {
  case "$1" in
    linux32)       echo rehlds-linux-i386 ;;
    linux64)       echo rehlds-linux-amd64 ;;
    linuxarm64)    echo rehlds-linux-aarch64 ;;
    windows)       echo rehlds-windows-i386 ;;
    windows-amd64) echo rehlds-windows-amd64 ;;
    # rehlds-ci-*: skipped (Publish aggregate is redundant with per-arch zips)
  esac
}

# (submodule path, github slug, mapper function)
consumers=(
  "amxmodx          goldsrc-net/amxmodx          map_amxmodx"
  "rcbotold         goldsrc-net/rcbotold         map_rcbotold"
  "Metamod-R        goldsrc-net/Metamod-R        map_metamod_r"
  "halflife-updated goldsrc-net/halflife-updated map_halflife_updated"
  "ReHLDS           goldsrc-net/ReHLDS           map_rehlds"
)

for entry in "${consumers[@]}"; do
  read -r sub slug mapper <<< "$entry"
  sha=$(git ls-files -s "$sub" | awk '{print $2}')
  if [ -z "$sha" ]; then
    echo "::error::no pinned SHA for $sub"
    exit 1
  fi
  echo "==== $slug @ $sha ===="

  # Latest green run for this SHA across all workflows
  run_id=$(gh api "repos/$slug/actions/runs?head_sha=$sha&per_page=20" \
           --jq '[.workflow_runs[] | select(.conclusion == "success")] | .[0].id // empty')
  if [ -z "$run_id" ]; then
    echo "::error::no successful CI run for $slug @ $sha"
    exit 1
  fi
  echo "  run: $run_id"

  # Iterate artifacts using process substitution so the loop's variable
  # state and exit codes propagate to the outer shell.
  while IFS=$'\t' read -r aname aid; do
    target=$("$mapper" "$aname" || true)
    if [ -z "$target" ]; then
      printf '  skip:  %s\n' "$aname"
      continue
    fi
    out="$OUT_DIR/${target}.zip"
    printf '  fetch: %-40s -> %s\n' "$aname" "$(basename "$out")"
    gh api "repos/$slug/actions/artifacts/$aid/zip" > "$out"
    if [ ! -s "$out" ]; then
      echo "::error::empty download for $aname (-> $out)"
      exit 1
    fi
  done < <(gh api "repos/$slug/actions/runs/$run_id/artifacts" \
           --jq '.artifacts[] | "\(.name)\t\(.id)"')
done

# --------------------------------------------------------------------
# Post-fetch reshape: overlay vendored upstream release-data onto each
# per-arch rcbotold zip.
#
# Upstream APGRoboCop/rcbotold v1.51b13's release zip ships a curated
# rcbot/ data tree (botprofiles, waypoints, visibility, map_configs,
# manual, dlls/readme.txt) that the maintainer assembles by hand at
# release time — those files don't live in any branch of the source
# repo, so no per-consumer CI fix could fill the gap.  We vendor the
# non-binary tree under vendor/rcbot-release-data/ and overlay it onto
# every rcbotold-<arch>.zip after download.  Collisions (files our CI
# already shipped) resolve to the vendored upstream version.
# --------------------------------------------------------------------
RCBOT_VENDOR="${RCBOT_VENDOR:-vendor/rcbot-release-data}"
if [ -d "$RCBOT_VENDOR" ]; then
  echo
  echo "==== overlay vendored rcbot release-data ===="
  RCBOT_VENDOR_ABS=$(cd "$RCBOT_VENDOR" && pwd)
  OUT_DIR_ABS=$(cd "$OUT_DIR" && pwd)
  for arch in linux-i386 linux-amd64 linux-aarch64 windows-i386 windows-amd64; do
    z="$OUT_DIR_ABS/rcbotold-${arch}.zip"
    [ -f "$z" ] || continue
    tmpdir=$(mktemp -d)
    ( cd "$tmpdir" && unzip -q "$z" )
    cp -R "$RCBOT_VENDOR_ABS/." "$tmpdir/"
    # Re-zip in place: delete old, create fresh from $tmpdir contents.
    rm -f "$z"
    ( cd "$tmpdir" && zip -qr "$z" . )
    rm -rf "$tmpdir"
    printf '  overlay: %s\n' "$(basename "$z")"
  done
fi

echo
echo "Done. Release assets in $OUT_DIR/ ($(ls -1 "$OUT_DIR" | wc -l) files):"
ls -lah "$OUT_DIR/"
