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

Each target produces a deploy-ready `.so` against glibc ≥ 2.36, suitable
for any debian-12 / Ubuntu-22.04 / Raspberry-Pi-OS-bookworm host —
including SBC-class arm64 silicon (tested against a Soquartz4).

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
  branch (and upstream `master` for the support deps `metamod-hl1` +
  `hlsdk`).
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

`hlds64-buildchain:debian12` — debian:12 (bookworm) base with:

- **GCC 11** native + `gcc-11-multilib` for `-m32`/i386. Set as the
  unversioned `gcc`/`g++`/`cc`/`c++` via `update-alternatives`. Matches
  halflife-updated's `cmake/LinuxToolchain.cmake`-hardcoded version, so
  upstream's toolchain works unchanged.
- **gcc-11-aarch64-linux-gnu** cross-toolchain plus arm64 multi-arch
  sysroot (`libc6:arm64`, `libstdc++6:arm64`). The sysroot is
  load-bearing: AMBuild's `DetectCxx` compiles a probe binary then
  *executes* it. That binary is aarch64 ELF; QEMU + binfmt_misc on the
  host route it through emulation transparently.
- Unversioned `aarch64-linux-gnu-gcc` / `aarch64-linux-gnu-g++` symlinks
  in `/usr/bin/` so cmake toolchain files that probe
  `EXISTS /usr/bin/aarch64-linux-gnu-gcc` (halflife-updated, ReHLDS)
  pick them up automatically — no `AARCH64_GCC` env override needed.
- **MariaDB Connector/C** — `libmariadb-dev` (amd64 headers + dev libs)
  plus `libmariadb3:i386` and `libmariadb3:arm64` runtime libs for
  amxmodx's `mysqlx` module. Build with `--mysql=system`.
- **NASM 2.16** (Debian build — the Ubuntu ESM 2.16.01-1ubuntu0.1~esm1
  build is broken; smoke-tested at image-build time).
- **AMBuild 2.0** from upstream master, exposed via `/usr/local/bin/ambuild`
  and `/usr/local/bin/ambuild-python` wrapper scripts that exec the
  venv interpreter directly (symlinks lose the venv context).
- **CMake**, **Ninja** (ReHLDS uses `-G Ninja`), **python-is-python3**
  (required by ReHLDS's `appversion.sh`), build-essential, git, curl,
  pkg-config, file, binutils.

### Why debian:12

glibc 2.36 — old enough that produced binaries load on debian-12,
RPi-OS bookworm, and any glibc ≥ 2.36 host. Building against newer
glibc (Ubuntu 24.04's 2.39, etc.) would produce binaries that refuse
to load on the SBC-class deployment targets.

### Why gcc-11 and not gcc-12

`halflife-updated/cmake/LinuxToolchain.cmake` hardcodes `gcc-11` /
`g++-11`. Rather than carry a patch on top of upstream, the buildchain
matches that version. gcc-11 builds the rest of the stack identically
to gcc-12 (no language- or codegen-relevant difference for this code).

## Special-case notes

### halflife-updated: `hl` target only

The Makefile builds only `--target hl` (the server `dlls/hl.so`), not
the `client` target. `cl_dll/client.so` presumes a 32-bit-client build
environment that doesn't fit our cross-arch scope (and isn't needed
for HLDS server deployment anyway).

### amxmodx: classic-metamod layout, `--mysql=system`

amxmodx's `detectMetamod` probes `<metamod_path>/metamod/<header>` —
the *classic* flat layout used by `metamod-hl1`. Metamod-R's
`metamod/src/<header>` layout doesn't match, so the Makefile points
amxmodx at `metamod-hl1` for its `meta_api.h` (it doesn't link against
the binary; just consumes the header).

`--mysql=system` is the sentinel that tells `modules/mysqlx/AMBuilder`
to use Debian's `libmariadb-dev` headers (`/usr/include/mariadb/*`)
and dynamically link `libmariadb.so.3`.

### Aarch64: cross-compile, not platform switch

aarch64 builds use the gcc-11 cross-toolchain inside the same
linux/amd64 image — *no* `--platform=linux/arm64`. Faster than
emulating the whole build environment, and avoids needing real arm64
hardware in CI. AMBuild's compiler-probe execution still works thanks
to the bundled arm64 sysroot + host binfmt_misc + qemu-user-static.

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

Edit, configure, and build manually with ambuild / cmake. All tools
on PATH; gcc/g++ resolve to gcc-11 unversioned;
`aarch64-linux-gnu-gcc`/`g++` resolve to gcc-11 cross.

### Rebuild after a Dockerfile change

```bash
make image
```

## Troubleshooting

- **"Could not find MySQL"** when building amxmodx → pass
  `--mysql=system` (the Makefile already does; check you're using a
  recent version of the Makefile).
- **"meta_api.h: No such file or directory"** building amxmodx → check
  `METAMOD_HL1_PATH`. amxmodx wants `metamod-hl1`, **not** `Metamod-R`.
- **"Compiler not found"** during cmake configure on i386 → check that
  `gcc-11` is actually installed in the image. The buildchain installs
  it explicitly for halflife-updated's toolchain.
- **aarch64 binary refuses to load on the deployment target** with
  glibc-version errors → you've built against a newer glibc than the
  deployment target. The buildchain pins glibc 2.36 specifically;
  don't switch the base image to ubuntu:latest.
- **NASM rejects valid syntax** → only happens on Ubuntu hosts running
  the ESM NASM. The Debian build the image uses is fine, and the image
  smoke-tests it at build time.

## License

Buildchain itself: MIT. Each consumer project retains its own license
(GPL/various — see each repo).
