# hlds64-buildchain (quic branch) — the 64-bit build image PLUS the QUIC toolchain.
#
# Same base as main (goldsrc-net/build-containers/debian10 — the full 64-bit toolchain,
# glibc-2.28 floor, cmake 3.29, multilib + aarch64 cross), plus the QUIC-only extras:
# libcurl (ReHLDS ENABLE_QUIC web-auth) and the Rust toolchain (ReHLDS cross-builds
# quiche via cargo). INTERNAL/MANUAL image — build it locally with `make image` on the
# quic branch. It is never published; published 64-bit images stay QUIC-free.
FROM ghcr.io/goldsrc-net/build-containers/debian10:latest

ENV DEBIAN_FRONTEND=noninteractive

# libcurl (dev) for ReHLDS's ENABLE_QUIC web-account ticket validation — the connect
# path POSTs to goldsrc.net over HTTPS. Install the -dev for amd64 + arm64.
RUN apt-get -o Acquire::Check-Valid-Until=false update && \
    apt-get install -y --no-install-recommends \
      libcurl4-openssl-dev libcurl4-openssl-dev:arm64 \
 && rm -rf /var/lib/apt/lists/*

# Rust toolchain — ReHLDS's ENABLE_QUIC build cross-compiles quiche (QUIC/WebTransport,
# vendored BoringSSL) from CMake via cargo. Installed into /opt so a non-root host uid
# (the orchestrator runs as the caller's uid) can use it. The i686/aarch64 std targets
# let quiche cross-build for all three arches at the debian:buster glibc-2.28 floor.
ENV RUSTUP_HOME=/opt/rustup CARGO_HOME=/opt/cargo
ENV PATH=/opt/cargo/bin:$PATH
RUN curl -sSf https://sh.rustup.rs | sh -s -- -y \
      --default-toolchain 1.82.0 --profile minimal \
 && rustup target add aarch64-unknown-linux-gnu i686-unknown-linux-gnu \
 && chmod -R a+rwX /opt/rustup /opt/cargo \
 && rustc --version
# /etc/profile rebuilds PATH for login shells (dropping the ENV PATH); a profile.d
# drop-in keeps cargo on PATH so ReHLDS's cmake cargo invocation finds it.
RUN printf 'export PATH=/opt/cargo/bin:$PATH\n' > /etc/profile.d/rust.sh

WORKDIR /work
CMD ["bash", "-lc", "set -e; cmake --version | head -1; rustc --version; uname -m; exec bash"]
