# hlds64-buildchain — build environment for the goldsrc-net 64-bit server stack
# (amxmodx, Metamod-R, halflife-updated, ReHLDS, rcbotold on their 64bit branches).
#
# All build tooling now lives in the base image, goldsrc-net/build-containers
# (its 64bit branch): debian:buster / glibc-2.28 floor, clang-11 + gcc-multilib,
# aarch64 cross-toolchain + arm64 runtime sysroot, cmake 3.29, nasm, rsync,
# libmariadb, and misc utils. That image is published to GHCR and consumed
# DIRECTLY by every repo's CI (see mod-ts .github/workflows/ci-cd.yml) — there is
# no separately-published buildchain image anymore.
#
# So on the clean 64-bit line this image adds nothing; it exists only so the
# Makefile's `hlds64-buildchain:debian10` tag resolves for local `make image`
# builds. QUIC (Rust/quiche + libcurl) is the `quic` branch's extra layer, for
# manual QUIC builds only — published 64-bit images stay QUIC-free.
FROM ghcr.io/goldsrc-net/build-containers/debian10:latest

WORKDIR /work

# Print the toolchain on start so build logs record the exact environment.
CMD ["bash", "-lc", "set -e; \
      gcc --version | head -1; \
      command -v aarch64-linux-gnu-gcc >/dev/null && aarch64-linux-gnu-gcc --version | head -1 || true; \
      cmake --version | head -1; \
      echo \"glibc: $(ldd --version | head -1)\"; \
      uname -m; \
      exec bash"]
