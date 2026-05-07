# hlds64-buildchain orchestrator
#
# Builds amxmodx (and eventually Metamod-R, halflife-updated, ReHLDS) on
# the 64bit branches inside debian:12 docker images.
#
# Two images, one Dockerfile:
#   hlds64-buildchain:debian12-amd64  — used for i386 and amd64 builds
#   hlds64-buildchain:debian12-arm64  — used for aarch64 builds
#
# AMBuild compiles + EXECUTES a probe program during DetectCxx, so a
# cross-compile from amd64 → aarch64 fails (the probe binary is
# aarch64 ELF and won't execute on amd64). The fix is to build aarch64
# inside an aarch64-platform container, where the host gcc IS aarch64
# native (via QEMU + binfmt_misc on the host). This requires
# qemu-user-static + binfmt_misc registered on the host kernel.
#
# Source repos default to ~/Packages/ but can be overridden:
#   make amxmodx-aarch64 SRC_ROOT=/path/to/srcs
#   make amxmodx-aarch64 AMXMODX_PATH=... METAMOD_PATH=... HLSDK_PATH=...
#
# Usage:
#   make image-amd64       # build the amd64 image (one-time)
#   make image-arm64       # build the arm64 image (one-time, slow under QEMU)
#   make image             # both
#   make amxmodx-i386      # build amxmodx for i386
#   make amxmodx-amd64     # build amxmodx for amd64
#   make amxmodx-aarch64   # native-arm64-emulated build via QEMU
#   make amxmodx-all       # all three
#   make shell-amd64       # interactive shell in the amd64 build image
#   make shell-arm64       # interactive shell in the arm64 build image
#   make clean             # wipe build_* dirs in source trees

# --- configuration ---------------------------------------------------

IMAGE_BASE := hlds64-buildchain:debian12
IMAGE_AMD  := $(IMAGE_BASE)-amd64
IMAGE_ARM  := $(IMAGE_BASE)-arm64

SRC_ROOT   ?= $(HOME)/Packages
AMXMODX    := $(or $(AMXMODX_PATH),$(SRC_ROOT)/amxmodx)
METAMOD    := $(or $(METAMOD_PATH),$(SRC_ROOT)/metamod-hl1)
HLSDK      := $(or $(HLSDK_PATH),$(SRC_ROOT)/hlsdk)

DOCKER     := docker
# BuildKit on this host (Docker Desktop 29.4.2) intermittently fails to
# fetch apt indexes during `docker build` despite `docker run` working
# fine. The legacy builder is reliable.
DOCKER_BUILD := DOCKER_BUILDKIT=0 $(DOCKER) build

# Volume mounts shared by all amxmodx-* targets.
VOLS := \
  -v $(AMXMODX):/work/amxmodx \
  -v $(METAMOD):/work/metamod \
  -v $(HLSDK):/work/hlsdk

DOCKER_RUN_AMD := $(DOCKER) run --rm -i \
                    --platform=linux/amd64 \
                    --user $(shell id -u):$(shell id -g) \
                    $(VOLS) -w /work/amxmodx \
                    $(IMAGE_AMD)

DOCKER_RUN_ARM := $(DOCKER) run --rm -i \
                    --platform=linux/arm64 \
                    --user $(shell id -u):$(shell id -g) \
                    $(VOLS) -w /work/amxmodx \
                    $(IMAGE_ARM)

# --- targets ---------------------------------------------------------

.PHONY: image image-amd64 image-arm64 shell-amd64 shell-arm64 clean \
        amxmodx-i386 amxmodx-amd64 amxmodx-aarch64 amxmodx-all

image: image-amd64 image-arm64

image-amd64:
	$(DOCKER_BUILD) --platform=linux/amd64 -t $(IMAGE_AMD) .

image-arm64:
	$(DOCKER_BUILD) --platform=linux/arm64 -t $(IMAGE_ARM) .

shell-amd64:
	$(DOCKER) run --rm -it --platform=linux/amd64 \
	  --user $(shell id -u):$(shell id -g) \
	  $(VOLS) -w /work/amxmodx \
	  $(IMAGE_AMD)

shell-arm64:
	$(DOCKER) run --rm -it --platform=linux/arm64 \
	  --user $(shell id -u):$(shell id -g) \
	  $(VOLS) -w /work/amxmodx \
	  $(IMAGE_ARM)

# i386 and amd64 builds run inside the amd64 image with native gcc.
# Both need NASM. The configure pass uses --target-arch to dispatch
# the right -m flag and asm sources.
amxmodx-i386:
	@echo ">>> amxmodx (i386, in amd64 container)"
	$(DOCKER_RUN_AMD) bash -lc 'set -e; \
	  cd /work/amxmodx; \
	  rm -rf build_i386; \
	  mkdir build_i386; \
	  cd build_i386; \
	  ambuild-python ../configure.py \
	    --target-arch=i386 \
	    --no-mysql \
	    --metamod=/work/metamod \
	    --hlsdk=/work/hlsdk; \
	  ambuild'

amxmodx-amd64:
	@echo ">>> amxmodx (amd64, in amd64 container)"
	$(DOCKER_RUN_AMD) bash -lc 'set -e; \
	  cd /work/amxmodx; \
	  rm -rf build_amd64; \
	  mkdir build_amd64; \
	  cd build_amd64; \
	  ambuild-python ../configure.py \
	    --target-arch=amd64 \
	    --no-mysql \
	    --metamod=/work/metamod \
	    --hlsdk=/work/hlsdk; \
	  ambuild'

# aarch64 build cross-compiles from the amd64 container using the
# aarch64-linux-gnu cross-toolchain. The amd64 image bundles the arm64
# multi-arch sysroot (libc6:arm64) so AMBuild's probe binary can be
# executed by QEMU + binfmt_misc on the host. This is faster than the
# emulated-platform path and is the CI default.
#
# Fallback if cross-compile breaks for any reason: `make amxmodx-aarch64-emu`
# runs in the arm64-platform image natively (slow, fully emulated).
amxmodx-aarch64:
	@echo ">>> amxmodx (aarch64 cross from amd64 container)"
	$(DOCKER_RUN_AMD) bash -lc 'set -e; \
	  cd /work/amxmodx; \
	  rm -rf build_aarch64; \
	  mkdir build_aarch64; \
	  cd build_aarch64; \
	  CC=aarch64-linux-gnu-gcc-12 \
	  CXX=aarch64-linux-gnu-g++-12 \
	    ambuild-python ../configure.py \
	      --target-arch=aarch64 \
	      --no-mysql \
	      --metamod=/work/metamod \
	      --hlsdk=/work/hlsdk; \
	  ambuild'

amxmodx-aarch64-emu:
	@echo ">>> amxmodx (aarch64 native-emulated arm64 container)"
	$(DOCKER_RUN_ARM) bash -lc 'set -e; \
	  cd /work/amxmodx; \
	  rm -rf build_aarch64; \
	  mkdir build_aarch64; \
	  cd build_aarch64; \
	  ambuild-python ../configure.py \
	    --target-arch=aarch64 \
	    --no-mysql \
	    --metamod=/work/metamod \
	    --hlsdk=/work/hlsdk; \
	  ambuild'

amxmodx-all: amxmodx-i386 amxmodx-amd64 amxmodx-aarch64

clean:
	rm -rf $(AMXMODX)/build_i386 $(AMXMODX)/build_amd64 $(AMXMODX)/build_aarch64
