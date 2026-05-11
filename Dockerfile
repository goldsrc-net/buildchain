# hlds64-buildchain — reproducible build environment for amxmodx,
# Metamod-R, halflife-updated, ReHLDS, and rcbotold on the 64bit branches.
#
# Based on goldsrc-net/build-containers/debian10 — itself a goldsrc-net
# fork of alliedmodders/build-containers/debian10 with multilib, the
# aarch64 cross-toolchain + arm64 runtime sysroot, libmariadb-dev (+ per-
# arch runtimes), cmake/rsync/nasm all pre-baked. Matching upstream's
# amxmodx release-CI base means PRs filed upstream don't get rejected
# for "couldn't reproduce on our environment" reasons.
#
# debian:buster's glibc (2.28) gives binaries a low floor — they run on
# any host with glibc >= 2.28, including the goldsrc-net production
# Soquartz4 SBC (debian-12, glibc 2.36). Forward-compat is the standard
# direction here.
#
# Three intended usage modes (unchanged from the prior debian:12 base):
#   1. Native x86_64 build (default platform): produces i386 / amd64 .so
#   2. Native aarch64 build (--platform=linux/arm64, requires qemu-user
#      + binfmt_misc on the host): produces aarch64 .so
#   3. Cross-compile aarch64 from x86_64 host: uses the aarch64 cross
#      toolchain pre-installed in the base image
#
# The orchestrator (Makefile in this directory) handles invocation;
# see README.md.

FROM ghcr.io/goldsrc-net/build-containers/debian10:latest

ENV DEBIAN_FRONTEND=noninteractive

# The base image already provides (clang-11 + gcc-multilib + nasm + cmake
# + rsync + libmariadb-dev + aarch64 cross-toolchain + arm64 runtime
# sysroot + ambuild). We just need a couple of utilities the Makefile
# recipes rely on but the upstream image omits.
RUN apt-get -o Acquire::Check-Valid-Until=false update && \
    apt-get install -y --no-install-recommends \
      file binutils pkg-config python3-venv \
 && rm -rf /var/lib/apt/lists/*

# debian:buster's apt cmake is 3.13.4; AsmJit (Metamod-R / amxmodx
# submodule pin 0bd5787 and later) requires cmake >= 3.24. Install
# Kitware's official prebuilt cmake binary into /usr/local — bypasses
# pip entirely (debian:buster's pip 18 can't parse modern
# pyproject.toml). /usr/local/bin is ahead of /usr/bin in PATH so this
# transparently shadows the apt cmake.
RUN CMAKE_VERSION=3.29.6 \
 && curl -sSL "https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}-linux-x86_64.tar.gz" \
    | tar -xz -C /usr/local --strip-components=1

# Provide an `ambuild-python` wrapper so existing Makefile recipes work
# unchanged. The base image installs ambuild via pip3 (into system
# python) and exposes /usr/local/bin/ambuild; this wrapper just execs
# the same python.
RUN printf '#!/bin/sh\nexec /usr/bin/python3 "$@"\n' > /usr/local/bin/ambuild-python \
 && chmod +x /usr/local/bin/ambuild-python

# NASM smoke-test — confirms the system nasm assembles a minimal
# `section .text` / `global` source. Fails the image build immediately
# on a regression rather than during the first amxmodx build.
RUN printf 'section .text\nglobal foo\nfoo:\n    ret\n' > /tmp/nasm-smoke.asm \
 && nasm -f elf32 /tmp/nasm-smoke.asm -o /tmp/nasm-smoke.o \
 && rm /tmp/nasm-smoke.asm /tmp/nasm-smoke.o \
 && nasm -v

# Default workdir is /work — orchestrator mounts source repos here.
WORKDIR /work

# Sanity: print versions on container start so build logs show the
# exact toolchain used. The base sets CC=clang-11 / CXX=clang++-11.
CMD ["bash", "-lc", "set -e; \
      echo '--- toolchain versions ---'; \
      gcc --version | head -1; \
      g++ --version | head -1; \
      command -v clang >/dev/null && clang --version | head -1 || echo 'clang: not found'; \
      command -v aarch64-linux-gnu-gcc >/dev/null && aarch64-linux-gnu-gcc --version | head -1 || true; \
      nasm -v; \
      ambuild --help 2>&1 | head -1; \
      cmake --version | head -1; \
      echo \"glibc: $(ldd --version | head -1)\"; \
      uname -m; \
      echo '--- ready ---'; \
      exec bash"]
