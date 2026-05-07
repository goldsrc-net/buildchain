# hlds64-buildchain orchestrator
#
# One docker image (debian:12) with native gcc + cross-toolchains + arm64
# multi-arch sysroot. Cross-compiles aarch64 from the amd64 host using
# the bundled aarch64-linux-gnu-gcc-12. AMBuild's compiler-probe
# binaries execute via QEMU + binfmt_misc on the host using the
# bundled arm64 sysroot — no separate arm64 image, no platform switch.
#
# Same image will be used for amxmodx, Metamod-R, halflife-updated,
# ReHLDS — every target on every arch.
#
# Source repos default to ~/Packages/ but can be overridden:
#   make amxmodx-aarch64 SRC_ROOT=/path/to/srcs
#   make amxmodx-aarch64 AMXMODX_PATH=... METAMOD_PATH=... HLSDK_PATH=...
#
# Usage:
#   make image             # build the docker image (one-time)
#   make amxmodx-i386      # build amxmodx for i386
#   make amxmodx-amd64     # build amxmodx for amd64
#   make amxmodx-aarch64   # cross-build amxmodx for aarch64
#   make amxmodx-all       # all three
#   make shell             # interactive shell in the build image
#   make clean             # wipe build_* dirs in source trees

# --- configuration ---------------------------------------------------

IMAGE      := hlds64-buildchain:debian12

SRC_ROOT   ?= $(HOME)/Packages
AMXMODX    := $(or $(AMXMODX_PATH),$(SRC_ROOT)/amxmodx)
METAMOD    := $(or $(METAMOD_PATH),$(SRC_ROOT)/metamod-hl1)
HLSDK      := $(or $(HLSDK_PATH),$(SRC_ROOT)/hlsdk)

DOCKER     := docker
# BuildKit on this host (Docker Desktop 29.4.2) intermittently fails to
# fetch apt indexes during `docker build` despite `docker run` working
# fine. The legacy builder is reliable.
DOCKER_BUILD := DOCKER_BUILDKIT=0 $(DOCKER) build

VOLS := \
  -v $(AMXMODX):/work/amxmodx \
  -v $(METAMOD):/work/metamod \
  -v $(HLSDK):/work/hlsdk

DOCKER_RUN := $(DOCKER) run --rm -i \
                --platform=linux/amd64 \
                --user $(shell id -u):$(shell id -g) \
                $(VOLS) -w /work/amxmodx \
                $(IMAGE)

# --- targets ---------------------------------------------------------

.PHONY: image shell clean amxmodx-i386 amxmodx-amd64 amxmodx-aarch64 amxmodx-all

image:
	$(DOCKER_BUILD) --platform=linux/amd64 -t $(IMAGE) .

shell:
	$(DOCKER) run --rm -it --platform=linux/amd64 \
	  --user $(shell id -u):$(shell id -g) \
	  $(VOLS) -w /work/amxmodx \
	  $(IMAGE)

# i386 and amd64 builds use native gcc-12 (multilib provides the i386
# toolchain). Both need NASM. The configure pass uses --target-arch to
# dispatch -m32 / -m64 and the right asm sources.
amxmodx-i386:
	@echo ">>> amxmodx (i386)"
	$(DOCKER_RUN) bash -lc 'set -e; \
	  cd /work/amxmodx; \
	  rm -rf build_i386; \
	  mkdir build_i386; \
	  cd build_i386; \
	  ambuild-python ../configure.py \
	    --target-arch=i386 \
	    --mysql=system \
	    --metamod=/work/metamod \
	    --hlsdk=/work/hlsdk; \
	  ambuild'

amxmodx-amd64:
	@echo ">>> amxmodx (amd64)"
	$(DOCKER_RUN) bash -lc 'set -e; \
	  cd /work/amxmodx; \
	  rm -rf build_amd64; \
	  mkdir build_amd64; \
	  cd build_amd64; \
	  ambuild-python ../configure.py \
	    --target-arch=amd64 \
	    --mysql=system \
	    --metamod=/work/metamod \
	    --hlsdk=/work/hlsdk; \
	  ambuild'

# aarch64 build cross-compiles using the aarch64-linux-gnu-gcc-12
# toolchain inside the same image. AMBuild executes its compiler-probe
# binary; that binary is aarch64 ELF, but the host (or container) has
# QEMU + binfmt_misc + arm64 sysroot, so it Just Works.
amxmodx-aarch64:
	@echo ">>> amxmodx (aarch64 cross)"
	$(DOCKER_RUN) bash -lc 'set -e; \
	  cd /work/amxmodx; \
	  rm -rf build_aarch64; \
	  mkdir build_aarch64; \
	  cd build_aarch64; \
	  CC=aarch64-linux-gnu-gcc-12 \
	  CXX=aarch64-linux-gnu-g++-12 \
	    ambuild-python ../configure.py \
	      --target-arch=aarch64 \
	      --mysql=system \
	      --metamod=/work/metamod \
	      --hlsdk=/work/hlsdk; \
	  ambuild'

amxmodx-all: amxmodx-i386 amxmodx-amd64 amxmodx-aarch64

clean:
	rm -rf $(AMXMODX)/build_i386 $(AMXMODX)/build_amd64 $(AMXMODX)/build_aarch64
