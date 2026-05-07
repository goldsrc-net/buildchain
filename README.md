# hlds64-buildchain

Reproducible build environment for the 64-bit / aarch64 port of the
amxmodx + Metamod-R + halflife-updated + ReHLDS stack on their `64bit`
branches.

## What it provides

A **single** `hlds64-buildchain:debian12` image that handles every
target arch — i386, amd64, aarch64 — via cross-compilation. No
separate per-arch images, no platform switching at run time.

- `Dockerfile` — debian:12 base with:
  - GCC 12 native + i386 multilib + aarch64 cross-toolchain
  - arm64 multi-arch sysroot (so AMBuild's compiler-probe binaries
    execute via QEMU + binfmt_misc on the host)
  - NASM 2.16 (Debian build, syntax-correct unlike the Ubuntu ESM build)
  - AMBuild 2.0 from upstream master
  - Python 3.11
- `Makefile` — orchestrator with per-arch build targets.

## Why debian:12

glibc 2.36 — old enough that the produced binaries load on debian-12,
RPi-OS bookworm, and any glibc >= 2.36 host. Building against newer
glibc (Ubuntu 24.04's 2.39, etc.) would produce binaries that refuse
to load on the deployment targets.

## Source layout assumed

```
~/Packages/
  amxmodx/       # this repo's main target (64bit branch)
  metamod-hl1/   # the Metamod the build links against
  hlsdk/         # Half-Life SDK headers
  Metamod-R/     # the modernized Metamod (separate target, similar buildchain)
```

The Makefile mounts these into `/work/{amxmodx,metamod,hlsdk}` inside
the container.

## Quick start

```bash
make image                 # one-time: build the docker image
make amxmodx-aarch64       # cross-build amxmodx for aarch64
make amxmodx-all           # i386 + amd64 + aarch64
make shell                 # drop into the container for ad-hoc work
```

Output binaries land in `../amxmodx/build_<arch>/`.

## NASM correctness check

The Dockerfile bakes in a smoke-test for the system NASM (assembles a
trivial `section .text` / `global` source). On Ubuntu 24.04 the ESM
NASM (`2.16.01-1ubuntu0.1~esm1`) is broken and rejects valid syntax;
the Debian 12 build (`2.16.01-1`) is fine. If the smoke test ever
starts failing, fall back to building NASM 2.16.03 from source.

## Why an orchestrator and not host builds

The host (Ubuntu 24.04) has:
- A broken NASM (Ubuntu ESM regression)
- Newer glibc than the deployment target (2.39 vs 2.36)
- No reproducible toolchain pin

Containerizing fixes all three.
