# hlds64-buildchain

Reproducible build environment for the 64-bit / aarch64 port of the
GoldSrc dedicated-server plugin stack. **One docker image, one Makefile,
fifteen build targets** — every project, every architecture.

## What it builds

| Project | i386 | amd64 | aarch64 |
|---|---|---|---|
| [`rcbotold`](https://github.com/APGRoboCop/rcbotold)            | ✅ | ✅ | ✅ |
| [`Metamod-R`](https://github.com/theAsmodai/metamod-r)          | ✅ | ✅ | ✅ |
| [`amxmodx`](https://github.com/alliedmodders/amxmodx)           | ✅ | ✅ | ✅ |
| [`halflife-updated`](https://github.com/twhl-community/halflife-updated) | ✅ | ✅ | ✅ (server `hl.so` only) |
| [`ReHLDS`](https://github.com/dreamstalker/rehlds)              | ✅ | ✅ | ✅ |

Each target produces a deploy-ready `.so` with a **glibc 2.28** floor —
runs on any debian-10 (buster) host or newer, including debian-12,
Ubuntu-22.04, Raspberry-Pi-OS-bookworm, and SBC-class arm64 silicon
(tested against a Soquartz4 running debian-12 / glibc-2.36).

**Windows binaries** (Win32 and Win64) for the same five projects are
produced by each consumer repo's own CI workflow, not by this
buildchain.  The `release-bundle` workflow here aggregates the Linux
binaries built by this Makefile with the Windows binaries from
consumer CI into a single set of per-(project × OS × arch) zip
assets attached to a `goldsrc-net/buildchain` release.

## Quick start

```bash
make image                       # one-time: build the docker image
make all                         # everything: 5 projects × 3 archs = 15 builds
```

That's it. Output binaries land inside each project's source tree
under `build_<arch>/` (ambuild) or `build-<arch>/` (cmake). See
[Output paths](#output-paths) for exact locations.

## Prerequisites

- **Docker** (Desktop or Engine, any reasonably recent version)
- **Submodules initialized.** If you cloned with `--recursive`, you're
  done. Otherwise:
  ```bash
  git submodule update --init --recursive
  ```
  The submodules pin known-good SHAs of each consumer repo's `64bit`
  branch — except `halflife-updated`, which tracks `64bit-demo`
  (defined as `64bit + 1 demo-only commit` that lets `hl.so` act as
  the valve gamedll for the showcase deploy).  Support deps:
  `metamod-hl1` tracks upstream `alliedmodders/metamod-hl1` master,
  `hlsdk` tracks our fork's `64bit` branch, and `build-containers`
  tracks our fork's `main` (it produces the base docker image).
- **About 8 GB of disk** for the docker image + build artifacts.

## Build commands

### Aggregate targets

```bash
make all          # every project × every arch (15 builds)
make i386         # every project, i386 only       (5 builds)
make amd64        # every project, amd64 only      (5 builds)
make aarch64      # every project, aarch64 only    (5 builds)
```

### Per-project (one project, all three arches)

```bash
make rcbot-all
make metamod-r-all
make amxmodx-all
make halflife-updated-all
make rehlds-all
```

### One target at a time (the building blocks)

```bash
make rcbot-i386            make rcbot-amd64            make rcbot-aarch64
make metamod-r-i386        make metamod-r-amd64        make metamod-r-aarch64
make amxmodx-i386          make amxmodx-amd64          make amxmodx-aarch64
make halflife-updated-i386 make halflife-updated-amd64 make halflife-updated-aarch64
make rehlds-i386           make rehlds-amd64           make rehlds-aarch64
```

### Utility

```bash
make image    # rebuild the docker image (after Dockerfile change)
make shell    # interactive bash in the build image with all repos mounted
make clean    # wipe build_*/build-* dirs across all repos
```

## Source paths

Defaults to `$(CURDIR)/<project>/` — the buildchain's own pinned
submodules. Override `SRC_ROOT` to build against trees somewhere else
(e.g. your local working copies during iteration), or override
individual projects:

```bash
# build against your live local trees instead of the pinned submodules
make all SRC_ROOT=$HOME/Packages

# point at a non-default location for one project, leave the rest pinned
make halflife-updated-aarch64 HALFLIFE_PATH=/path/to/halflife-updated
```

Specific overrides: `RCBOT_PATH`, `METAMODR_PATH`, `METAMOD_HL1_PATH`,
`AMXMODX_PATH`, `HLSDK_PATH`, `HALFLIFE_PATH`, `REHLDS_PATH`.

## Output paths

Each build's deploy-ready binary:

| Project | i386 | amd64 | aarch64 |
|---|---|---|---|
| rcbotold | `build_i386/rcbot_mm_i386/linux-x86/rcbot_mm_i386.so` | `build_amd64/.../linux-x86_64/rcbot_mm_amd64.so` | `build_aarch64/.../linux-arm64/rcbot_mm_aarch64.so` |
| Metamod-R | `build-i386/metamod/metamod_i386.so` | `build-amd64/metamod/metamod_amd64.so` | `build-aarch64/metamod/metamod_aarch64.so` |
| amxmodx | `build_i386/amxmodx/amxmodx_mm_i386/amxmodx_mm_i386.so` | `build_amd64/.../amxmodx_mm_amd64.so` | `build_aarch64/.../amxmodx_mm_aarch64.so` |
| halflife-updated | `build-i386/dlls/hl.so` | `build-amd64/dlls/hl.so` | `build-aarch64/dlls/hl.so` |
| ReHLDS | `build-i386/rehlds/engine_i486.so` | `build-amd64/rehlds/engine_i486.so` | `build-aarch64/rehlds/engine_i486.so` |

Naming conventions:
- `build_<arch>` (underscore) — AMBuild projects (rcbotold, amxmodx).
- `build-<arch>` (hyphen) — CMake projects (Metamod-R, halflife-updated, ReHLDS).
- Output suffix `_i386` / `_amd64` / `_aarch64` matches the
  ecosystem-wide convention used across all five projects.

## What's inside the docker image

`hlds64-buildchain:debian10` — based on
[`ghcr.io/goldsrc-net/build-containers/debian10`](https://github.com/goldsrc-net/build-containers),
itself a `debian:buster` image (multi-arch, amd64 + arm64) with the
toolchain matrix upstream amxmodx uses for its release CI:

- **clang-11** as the default `CC` / `CXX` (from `apt.llvm.org`).
  Matches alliedmodders' upstream amxmodx release CI exactly, so a
  CI-style build inside this image reproduces upstream binaries.
- **gcc-8.3** as the system fallback compiler, plus `gcc-multilib` /
  `g++-multilib` / `lib32z1-dev` for `-m32` i386 builds.  The Makefile
  forces `CC=gcc CXX=g++` for i386 and amd64 to dodge a clang-11
  `-Werror=int-conversion` warning on amxmodx's
  `(long)NULL → void*` pattern.
- **aarch64-linux-gnu-gcc-8.3** cross-toolchain plus an arm64 multi-arch
  runtime sysroot (`libc6:arm64`, `libstdc++6:arm64`).  The sysroot is
  load-bearing: AMBuild's `DetectCxx` compiles a probe binary then
  *executes* it.  That binary is aarch64 ELF; QEMU + binfmt_misc on
  the host route it through emulation transparently.
- **clang-as-aarch64-cross** for cmake-driven projects (Metamod-R,
  halflife-updated, ReHLDS).  Their cmake toolchain files
  (`cmake/LinuxToolchain-aarch64.cmake` etc.) probe for clang via
  `find_program` and drive cross-compile via `--target=aarch64-linux-gnu`.
  This is necessary because ReHLDS's vendored `sse2neon.h` requires
  gcc ≥ 10 or clang (it uses `__has_builtin` and `vld1q_u8_x4`);
  buster's cross-gcc is 8.3, which rejects the header.  AMBuild
  projects (rcbot, Metamod-R AMBuild path, amxmodx) stay on gcc-8.3
  cross — they build clean without sse2neon.
- **MariaDB Connector/C 3.1.21** static-link staging trees at
  `/opt/mariadb-static-{i386,amd64,aarch64}/`.  Each tree carries
  `include/` (`mysql.h`) and `lib/libmysqlclient_r.a` (renamed from
  `libmariadbclient.a` to match the upstream filename amxmodx's
  `mysqlx/AMBuilder` hardcodes).  Built `mysql_amxx_*.so` modules have
  no `libmariadb.so.3` in NEEDED — fully self-contained, no
  `apt install libmariadb3` required on deploy hosts.
- **NASM 2.14** (smoke-tested at image-build time).
- **AMBuild 2.0** from upstream master, exposed via `/usr/local/bin/ambuild`
  and `/usr/local/bin/ambuild-python` wrapper scripts that exec the
  venv interpreter directly (symlinks lose the venv context).
- **CMake 3.29.6** from Kitware's release tarball (unpacked into
  `/usr/local`).  buster's apt cmake is 3.13.4; AsmJit (pinned in
  Metamod-R + amxmodx) requires ≥ 3.24.  pip cmake doesn't work
  either — buster's pip 18 can't parse modern `pyproject.toml`.
- **Ninja** (ReHLDS uses `-G Ninja`), **python-is-python3** (required by
  ReHLDS's `appversion.sh`), git, rsync, curl, pkg-config, file,
  binutils.

### Why debian:10 (buster)

The base image matches upstream amxmodx's release CI exactly.  Upstream
amxmodx pins its CI to `ghcr.io/alliedmodders/build-containers/debian10`;
we fork the same image (with net-additive multi-arch + multilib + sysroot
additions) to keep the toolchain byte-equivalent.  Side benefit:
debian:buster's glibc is **2.28**, low enough that produced binaries
load on every modern Linux deploy target (debian-12 at glibc-2.36,
Ubuntu 24.04 at glibc-2.39, etc.).

### Why clang-11 (and not gcc-N)

clang-11 is the default the upstream amxmodx CI uses, so adopting it
keeps that CI byte-equivalent.  gcc-8.3 (buster's system compiler) is
still installed and used by the Makefile for i386 / amd64 of all
projects — clang-11 trips on a couple of amxmodx's vendored-code C
patterns that gcc only warns about — but clang-11 still drives all
cmake-side aarch64 cross-compiles (see above).  The whole stack is a
**pinned environment**, not a "detect host gcc" arrangement.

## Special-case notes

### halflife-updated: `hl` target only

The Makefile builds only `--target hl` (the server `dlls/hl.so`), not
the `client` target. `cl_dll/client.so` presumes a 32-bit-client build
environment that doesn't fit our cross-arch scope (and isn't needed
for HLDS server deployment anyway).

### amxmodx: classic-metamod layout, static MariaDB Connector/C

amxmodx's `detectMetamod` probes `<metamod_path>/metamod/<header>` —
the *classic* flat layout used by `metamod-hl1`.  Metamod-R's
`metamod/src/<header>` layout doesn't match, so the Makefile points
amxmodx at `metamod-hl1` for its `meta_api.h` (it doesn't link against
the binary; just consumes the header).

`--mysql=/opt/mariadb-static-<arch>` points `modules/mysqlx/AMBuilder`
at the per-arch MariaDB Connector/C 3.1.21 staging tree baked into the
docker image.  The resulting `mysql_amxx_<arch>.so` has no
`libmariadb.so.3` in NEEDED — fully self-contained, drops in on any
deploy host without installing libmariadb3 separately.  The same
approach is used by the consumer-CI Windows builds, which extract the
MariaDB Connector/C 3.1.21 MSI on the runner and link the bundled
`mariadbclient.lib` statically.

### ReHLDS: bundled libsteam_api shim

ReHLDS ships its own from-source SteamWorks v1.60 ABI shim under
`dep/libsteam_api/`, producing `rehlds/lib/{linux32,linux64,linuxarm64,
win32,win64}/{libsteam_api.so,steam_api.dll,steam_api64.dll}` as part
of the engine build.  Drop-in compatible with Valve's legacy v1.60
binary AND the Anniversary HLDS runtime — the Anniversary
`libsteam_api` hardcodes `SteamClient023` and won't negotiate down to
the engine 8684 `SteamClient012` ABI, but our shim does.  VAC engages
on every arch, verified against real Steam infrastructure.

### Aarch64: cross-compile, not platform switch

aarch64 builds cross-compile inside the same `linux/amd64` image —
*no* `--platform=linux/arm64`.  Faster than emulating the whole build
environment, and avoids needing real arm64 hardware in CI.  AMBuild
projects (rcbot, Metamod-R, amxmodx) use the gcc-8.3
`aarch64-linux-gnu-*` cross-toolchain; cmake projects (Metamod-R cmake
path, halflife-updated, ReHLDS) drive clang-as-cross via
`--target=aarch64-linux-gnu`.  AMBuild's compiler-probe execution still
works thanks to the bundled arm64 runtime sysroot + host
binfmt_misc + qemu-user-static.

### Image-build reliability

The Makefile uses `DOCKER_BUILDKIT=0` for `make image` — Docker Desktop
29.4.2's BuildKit intermittently fails to fetch apt indexes during
`docker build` despite `docker run` working fine. The legacy builder
is reliable. Drop the override if your local Docker doesn't have the
issue.

## Common operations

### Sanity-check a single binary

```bash
file ~/Packages/rcbotold/build_aarch64/rcbot_mm_aarch64/linux-arm64/rcbot_mm_aarch64.so
# ELF 64-bit LSB shared object, ARM aarch64, version 1 (SYSV), …
```

### Iterate without re-running the orchestrator

```bash
make shell    # bash inside the image with all source repos at /work/<project>
```

Edit, configure, and build manually with ambuild / cmake.  All tools
on PATH; the default `CC` / `CXX` is clang-11, with gcc-8.3 also
available as `gcc` / `g++`.  `aarch64-linux-gnu-gcc` / `g++` resolve
to the gcc-8.3 aarch64 cross-compiler; `clang --target=aarch64-linux-gnu`
also works for cmake-style cross builds.

### Rebuild after a Dockerfile change

```bash
make image
```

## Troubleshooting

- **"Could not find MySQL"** when building amxmodx → check the
  Makefile is passing `--mysql=/opt/mariadb-static-<arch>` (it does
  for all three arches).  The static staging trees are baked into
  the docker image at image-build time; if they're missing you've
  probably got a stale local image — run `make image` to rebuild.
- **"meta_api.h: No such file or directory"** building amxmodx → check
  `METAMOD_HL1_PATH`.  amxmodx wants `metamod-hl1`, **not** `Metamod-R`.
- **"Could not find compiler set in environment variable CC"** during
  cmake configure → the image's default `CC` is `clang-11`; for i386
  / amd64 the Makefile overrides this to `gcc` (gcc-8.3, buster's
  system compiler).  If you see this error in your own shell session,
  you've stepped outside the Makefile's env block — re-export
  `CC=gcc CXX=g++` for x86 builds, or
  `CC=aarch64-linux-gnu-gcc CXX=aarch64-linux-gnu-g++` for AMBuild
  aarch64 cross-builds.
- **aarch64 binary refuses to load on the deployment target** with
  glibc-version errors → you've built against a newer glibc than the
  deployment target.  The buildchain pins debian:buster's glibc 2.28
  specifically; don't switch the base image to a newer Debian or to
  ubuntu:latest.
- **NASM rejects valid syntax** → only happens on Ubuntu hosts running
  the ESM NASM.  The Debian build the image uses is fine, and the
  image smoke-tests it at build time.

## Verification

A buildchain CI workflow (`.github/workflows/verify-pins.yml`) gates
the buildchain on green CI from every consumer repo at the pinned
SHA.  The same logic is reusable as a local check:

```bash
bash scripts/verify-pins.sh
```

For each consumer-repo submodule, it reads the pinned SHA from the
buildchain index (`git ls-files -s`), looks up the latest successful
workflow run for that SHA via `gh api repos/<slug>/actions/runs?head_sha=...`,
and reports per-repo status.  Exits non-zero if any pin lacks a green
CI run.  Run after a `git submodule update` / pin bump to catch a
"pinned SHA without CI provenance" case before publishing a release.

Authenticates via the `gh` CLI's existing credentials locally, or
`GITHUB_TOKEN` (with `actions: read` permission) inside the CI
workflow.

## Release pipeline

Pre-built binaries are published as zips attached to releases on
[`goldsrc-net/buildchain`](https://github.com/goldsrc-net/buildchain/releases).
Each release contains **25 per-platform zip assets** — one for every
(project × OS × arch) combination across the supported matrix:

| Project | linux-i386 | linux-amd64 | linux-aarch64 | windows-i386 | windows-amd64 |
|---|---|---|---|---|---|
| rcbotold          | ✅ | ✅ | ✅ | ✅ | ✅ |
| metamod-r         | ✅ | ✅ | ✅ | ✅ | ✅ |
| amxmodx           | ✅ | ✅ | ✅ | ✅ | ✅ |
| halflife-updated  | ✅ | ✅ | ✅ | ✅ | ✅ |
| rehlds            | ✅ | ✅ | ✅ | ✅ | ✅ |

Asset name format: `<project>-<os>-<arch>.zip` (all lowercase,
hyphens).  Linux assets come from this buildchain's `make` output;
Windows assets come from each consumer repo's own CI run on the
pinned SHA.

### How a release is assembled

```bash
bash scripts/fetch-release-artifacts.sh
```

For each consumer-repo submodule, the script finds the latest green
CI run on the pinned SHA, downloads its artifacts, and renames them
into the uniform `<project>-<os>-<arch>.zip` scheme above.  Output
lands in `release-assets/`.  In CI this same script feeds the
release-bundle workflow that attaches the zips to a tagged release.

### Why per-(project × platform) zips, not bundled

Server operators rarely deploy the whole stack — most run one or two
mods on top of ReHLDS or stock HLDS.  A per-(project × platform) zip
lets you grab exactly what your install needs (e.g. just
`rehlds-linux-aarch64.zip` + `metamod-r-linux-aarch64.zip` for a
plain ReHLDS arm64 server) without unpacking a megazip.

## License

Buildchain itself: MIT. Each consumer project retains its own license
(GPL/various — see each repo).
