#!/usr/bin/env bash
#
# verify-pins.sh — confirm each consumer-repo submodule pin in
# the buildchain index has at least one successful CI run on
# the pinned SHA.  Exits non-zero with a per-repo error report
# if any pin is missing a green CI run.
#
# Used both locally and from the buildchain's CI workflow.
# Authenticates via the `gh` CLI's existing credentials (locally)
# or GITHUB_TOKEN (in CI).

set -euo pipefail

# submodule path => github org/repo slug
declare -A repos=(
  [rcbotold]=goldsrc-net/rcbotold
  [Metamod-R]=goldsrc-net/Metamod-R
  [amxmodx]=goldsrc-net/amxmodx
  [halflife-updated]=goldsrc-net/halflife-updated
  [ReHLDS]=goldsrc-net/ReHLDS
  [build-containers]=goldsrc-net/build-containers
)

# Ordered for stable output.
order=(rcbotold Metamod-R amxmodx halflife-updated ReHLDS build-containers)

fail=0

for sub in "${order[@]}"; do
  slug="${repos[$sub]}"

  # `git ls-files -s <path>` reads the submodule SHA from the index
  # (mode "160000 <sha> 0\t<path>"), which mirrors HEAD after a commit
  # AND reflects staged-but-uncommitted bumps — useful for previewing
  # a pin bump locally before committing.
  sha=$(git ls-files -s "$sub" 2>/dev/null | awk '{print $2}')

  if [ -z "$sha" ]; then
    printf '::error::%s: no SHA in buildchain index\n' "$sub"
    fail=1
    continue
  fi

  printf '\n=== %s @ %s ===\n' "$slug" "$sha"

  # Pull up to 10 runs for this SHA across all workflows / events.
  # Pick the one with the best conclusion: any `success` wins, else
  # report the most recent.
  runs_json=$(gh api "repos/$slug/actions/runs?head_sha=$sha&per_page=10" \
              --jq '.workflow_runs' 2>/dev/null || echo '[]')

  count=$(printf '%s' "$runs_json" | jq 'length')
  if [ "$count" -eq 0 ]; then
    printf '::error::%s @ %s — no CI runs found for this SHA\n' "$slug" "$sha"
    printf '  fix: trigger CI on this commit then retry\n'
    fail=1
    continue
  fi

  green=$(printf '%s' "$runs_json" \
          | jq '[.[] | select(.conclusion == "success")] | .[0]')

  if [ "$green" != "null" ] && [ -n "$green" ]; then
    wf=$(printf '%s' "$green" | jq -r .name)
    url=$(printf '%s' "$green" | jq -r .html_url)
    printf '  ✓ green: %s\n' "$wf"
    printf '    %s\n' "$url"
    continue
  fi

  # No green run — report the most recent run's status so the operator
  # can decide whether to wait or fix.
  latest=$(printf '%s' "$runs_json" | jq '.[0]')
  status=$(printf '%s' "$latest" | jq -r .status)
  conclusion=$(printf '%s' "$latest" | jq -r '.conclusion // "<none>"')
  url=$(printf '%s' "$latest" | jq -r .html_url)
  wf=$(printf '%s' "$latest" | jq -r .name)
  printf '::error::%s @ %s — no successful CI run (latest: %s/%s)\n' \
    "$slug" "$sha" "$status" "$conclusion"
  printf '  workflow: %s\n' "$wf"
  printf '  url: %s\n' "$url"
  fail=1
done

echo
if [ $fail -ne 0 ]; then
  echo '::error::One or more consumer pins lack a green CI run.'
  exit 1
fi

echo 'All consumer pins have green CI runs. ✓'
