# hlds64-buildchain — reproducible build environment for amxmodx,
# Metamod-R, halflife-updated, and ReHLDS on the 64bit branches.
#
# Built on debian:12 (bookworm, glibc 2.36) so the resulting binaries
# load cleanly on any glibc >= 2.36 host (including Soquartz4 / RPi5
# debian-12 deployments).
#
# Three intended usage modes:
#   1. Native x86_64 build (default platform): produces i386 / amd64 .so
#   2. Native aarch64 build (--platform=linux/arm64, requires qemu-user
#      + binfmt_misc on the host): produces aarch64 .so
#   3. Cross-compile aarch64 from x86_64 host: uses the aarch64 cross
#      toolchain installed below; faster than emulation, link-tested
#      against a debian-12 sysroot
#
# The orchestrator (Makefile in this directory) handles invocation;
# see README.md.

FROM debian:12

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    gcc-12 g++-12 \
    \
    git \
    curl \
    ca-certificates \
    \
    nasm \
    \
    python3 python3-pip python3-venv \
    \
    cmake \
    pkg-config \
    \
    file \
    binutils \
    \
    && rm -rf /var/lib/apt/lists/*

# Multilib (32-bit x86) is only available on amd64. On arm64 there is
# no multilib analog — the i386 build path doesn't apply there anyway,
# but on amd64 we want it for the i386 amxmodx target.
#
# linux-libc-dev:i386 supplies /usr/include/i386-linux-gnu/asm/errno.h
# and friends, which `cc -m32` searches for. gcc-multilib brings in
# the 64-bit variant only.
RUN if [ "$(dpkg --print-architecture)" = "amd64" ]; then \
      dpkg --add-architecture i386 \
      && apt-get update && apt-get install -y --no-install-recommends \
        gcc-multilib g++-multilib libc6-dev-i386 linux-libc-dev:i386 \
      && rm -rf /var/lib/apt/lists/*; \
    fi

# aarch64 cross-toolchain + arm64 multi-arch runtime sysroot. The
# sysroot is the load-bearing piece: AMBuild's DetectCxx compiles a
# probe binary then *executes* it. The kernel's binfmt_misc routes
# aarch64 ELFs through qemu-user-static; QEMU then needs
# /lib/ld-linux-aarch64.so.1 + libc to actually load. Without the
# sysroot the probe fails and AMBuild reports "Unable to find a
# suitable CC compiler".
#
# On arm64 hosts (--platform=linux/arm64) this whole block is skipped —
# the host gcc IS aarch64 native and no sysroot is needed.
RUN if [ "$(dpkg --print-architecture)" = "amd64" ]; then \
      dpkg --add-architecture arm64 \
      && apt-get update && apt-get install -y --no-install-recommends \
        gcc-12-aarch64-linux-gnu g++-12-aarch64-linux-gnu \
        binutils-aarch64-linux-gnu \
        libc6-dev-arm64-cross \
        libc6:arm64 libstdc++6:arm64 \
      && rm -rf /var/lib/apt/lists/*; \
    fi

# Provide unversioned cross-toolchain aliases so AMBuild can pick them
# up via CC=aarch64-linux-gnu-gcc / CXX=aarch64-linux-gnu-g++. Only
# matters on amd64 hosts.
RUN if [ "$(dpkg --print-architecture)" = "amd64" ]; then \
      ln -sf /usr/bin/aarch64-linux-gnu-gcc-12  /usr/local/bin/aarch64-linux-gnu-gcc; \
      ln -sf /usr/bin/aarch64-linux-gnu-g++-12  /usr/local/bin/aarch64-linux-gnu-g++; \
    fi

# AMBuild from upstream master. Not on PyPI; install from source.
# Symlinks lose the venv context (they resolve to system python), so we
# use small wrapper scripts that exec the venv interpreter directly.
RUN python3 -m venv /opt/ambuild-venv \
 && /opt/ambuild-venv/bin/pip install --no-cache-dir \
      git+https://github.com/alliedmodders/ambuild.git \
 && printf '#!/bin/sh\nexec /opt/ambuild-venv/bin/ambuild "$@"\n' > /usr/local/bin/ambuild \
 && printf '#!/bin/sh\nexec /opt/ambuild-venv/bin/python "$@"\n'  > /usr/local/bin/ambuild-python \
 && chmod +x /usr/local/bin/ambuild /usr/local/bin/ambuild-python

# NASM smoke-test: confirm the system nasm assembles a `section .text`
# / `global` source. The Ubuntu ESM 2.16.01-1ubuntu0.1~esm1 build is
# broken; the Debian 12 build is fine. Bake the test into the image so
# we fail fast on a regression.
RUN printf 'section .text\nglobal foo\nfoo:\n    ret\n' > /tmp/nasm-smoke.asm \
 && nasm -f elf32 /tmp/nasm-smoke.asm -o /tmp/nasm-smoke.o \
 && rm /tmp/nasm-smoke.asm /tmp/nasm-smoke.o \
 && nasm -v

# Default workdir is /work — orchestrator mounts source repos here.
WORKDIR /work

# Sanity: print versions on container start so build logs show the
# exact toolchain used.
CMD ["bash", "-lc", "set -e; \
      echo '--- toolchain versions ---'; \
      gcc --version | head -1; \
      g++ --version | head -1; \
      if command -v aarch64-linux-gnu-gcc >/dev/null; then aarch64-linux-gnu-gcc --version | head -1; fi; \
      nasm -v; \
      ambuild --help 2>&1 | head -1; \
      uname -m; \
      echo '--- ready ---'; \
      exec bash"]
