# hlds64-buildchain orchestrator
#
# One docker image (debian:12) with native gcc + cross-toolchains + arm64
# multi-arch sysroot. Cross-compiles aarch64 from the amd64 host using
# the bundled aarch64-linux-gnu-gcc-12. AMBuild's compiler-probe
# binaries execute via QEMU + binfmt_misc on the host using the
# bundled arm64 sysroot — no separate arm64 image, no platform switch.
#
# Builds every project on every architecture: rcbotold, Metamod-R,
# amxmodx, halflife-updated, ReHLDS — each for i386, amd64, aarch64.
#
# Source repos default to ~/Packages/ but can be overridden:
#   make rcbot-aarch64          SRC_ROOT=/path/to/srcs
#   make halflife-updated-amd64 HALFLIFE_PATH=...
#
# Usage:
#   make image                 # build the docker image (one-time / on Dockerfile change)
#   make all                   # every project, every arch (5 × 3 = 15 builds)
#   make rcbot-all             # rcbot for all three arches
#   make rcbot-aarch64         # rcbot for one arch
#   make halflife-updated-i386 # one project, one arch
#   make shell                 # interactive shell in the build image
#   make clean                 # wipe build_*/build-* dirs in source trees

# --- configuration ---------------------------------------------------

IMAGE      := hlds64-buildchain:debian12

SRC_ROOT   ?= $(HOME)/Packages
RCBOT      := $(or $(RCBOT_PATH),$(SRC_ROOT)/rcbotold)
METAMODR   := $(or $(METAMODR_PATH),$(SRC_ROOT)/Metamod-R)
METAMOD_HL1 := $(or $(METAMOD_HL1_PATH),$(SRC_ROOT)/metamod-hl1)
AMXMODX    := $(or $(AMXMODX_PATH),$(SRC_ROOT)/amxmodx)
HLSDK      := $(or $(HLSDK_PATH),$(SRC_ROOT)/hlsdk)
HALFLIFE   := $(or $(HALFLIFE_PATH),$(SRC_ROOT)/halflife-updated)
REHLDS     := $(or $(REHLDS_PATH),$(SRC_ROOT)/ReHLDS)

DOCKER     := docker
# BuildKit on this host (Docker Desktop 29.4.2) intermittently fails to
# fetch apt indexes during `docker build` despite `docker run` working
# fine. The legacy builder is reliable.
DOCKER_BUILD := DOCKER_BUILDKIT=0 $(DOCKER) build

# All five source trees mounted read-write into /work/<name>. Build
# directories live inside each source tree (build-<arch> for cmake
# projects, build_<arch> for ambuild projects).
VOLS := \
  -v $(RCBOT):/work/rcbotold \
  -v $(METAMODR):/work/Metamod-R \
  -v $(METAMOD_HL1):/work/metamod-hl1 \
  -v $(AMXMODX):/work/amxmodx \
  -v $(HLSDK):/work/hlsdk \
  -v $(HALFLIFE):/work/halflife-updated \
  -v $(REHLDS):/work/ReHLDS

DOCKER_RUN := $(DOCKER) run --rm -i \
                --platform=linux/amd64 \
                --user $(shell id -u):$(shell id -g) \
                $(VOLS) \
                $(IMAGE)

# Per-arch env. aarch64 forces the cross-compiler explicitly so AMBuild
# and any cmake `EXISTS /usr/bin/aarch64-linux-gnu-gcc` probe both pick
# it up; i386 / amd64 use the buildchain's native gcc-12.
ENV_i386    :=
ENV_amd64   :=
ENV_aarch64 := CC=aarch64-linux-gnu-gcc CXX=aarch64-linux-gnu-g++

# --- helpers ---------------------------------------------------------

# Generic ambuild build pattern. Args: $1=src dir name, $2=arch, $3=extra configure flags
define AMBUILD_RECIPE
@echo ">>> $(1) ($(2))"
$(DOCKER_RUN) bash -lc 'set -e; \
  cd /work/$(1); \
  rm -rf build_$(2); \
  mkdir build_$(2); \
  cd build_$(2); \
  $(ENV_$(2)) ambuild-python ../configure.py --target-arch=$(2) $(3); \
  ambuild'
endef

# Generic cmake build pattern. Args: $1=src dir name, $2=arch, $3=build dir suffix
# (typically build-<arch>), $4=extra cmake configure flags, $5=optional --target arg
define CMAKE_RECIPE
@echo ">>> $(1) ($(2))"
$(DOCKER_RUN) bash -lc 'set -e; \
  cd /work/$(1); \
  rm -rf $(3); \
  mkdir $(3); \
  cd $(3); \
  $(ENV_$(2)) cmake -S /work/$(1) -B . -DCMAKE_BUILD_TYPE=Release $(4); \
  cmake --build . -j$$(nproc) $(5)'
endef

# --- top-level targets ----------------------------------------------

.PHONY: image shell clean all
.PHONY: rcbot-i386 rcbot-amd64 rcbot-aarch64 rcbot-all
.PHONY: metamod-r-i386 metamod-r-amd64 metamod-r-aarch64 metamod-r-all
.PHONY: amxmodx-i386 amxmodx-amd64 amxmodx-aarch64 amxmodx-all
.PHONY: halflife-updated-i386 halflife-updated-amd64 halflife-updated-aarch64 halflife-updated-all
.PHONY: rehlds-i386 rehlds-amd64 rehlds-aarch64 rehlds-all

image:
	$(DOCKER_BUILD) --platform=linux/amd64 -t $(IMAGE) .

shell:
	$(DOCKER) run --rm -it --platform=linux/amd64 \
	  --user $(shell id -u):$(shell id -g) \
	  $(VOLS) -w /work \
	  $(IMAGE)

# --- rcbotold (ambuild, no extra deps) ------------------------------
rcbot-i386:
	$(call AMBUILD_RECIPE,rcbotold,i386,)
rcbot-amd64:
	$(call AMBUILD_RECIPE,rcbotold,amd64,)
rcbot-aarch64:
	$(call AMBUILD_RECIPE,rcbotold,aarch64,)
rcbot-all: rcbot-i386 rcbot-amd64 rcbot-aarch64

# --- Metamod-R (cmake) ----------------------------------------------
# i386: default invocation. amd64: -DBUILD_64BIT=ON. aarch64: toolchain file.
metamod-r-i386:
	$(call CMAKE_RECIPE,Metamod-R,i386,build-i386,,)
metamod-r-amd64:
	$(call CMAKE_RECIPE,Metamod-R,amd64,build-amd64,-DBUILD_64BIT=ON,)
metamod-r-aarch64:
	$(call CMAKE_RECIPE,Metamod-R,aarch64,build-aarch64,-DCMAKE_TOOLCHAIN_FILE=/work/Metamod-R/cmake/toolchain-aarch64-linux.cmake,)
metamod-r-all: metamod-r-i386 metamod-r-amd64 metamod-r-aarch64

# --- amxmodx (ambuild, needs metamod-hl1 + hlsdk + mysql) ------------
# Note: amxmodx expects the classic flat metamod layout (metamod-hl1),
# not Metamod-R's split-source layout. mysql=system uses libmariadb-dev
# from the buildchain image.
AMXMODX_FLAGS := --metamod=/work/metamod-hl1 --hlsdk=/work/hlsdk --mysql=system
amxmodx-i386:
	$(call AMBUILD_RECIPE,amxmodx,i386,$(AMXMODX_FLAGS))
amxmodx-amd64:
	$(call AMBUILD_RECIPE,amxmodx,amd64,$(AMXMODX_FLAGS))
amxmodx-aarch64:
	$(call AMBUILD_RECIPE,amxmodx,aarch64,$(AMXMODX_FLAGS))
amxmodx-all: amxmodx-i386 amxmodx-amd64 amxmodx-aarch64

# --- halflife-updated (cmake, only the hl server target) -------------
# We build the `hl` target only — the cl_dll/client target presumes a
# 32-bit-client build environment that doesn't fit our cross-arch
# scope (and isn't needed for HLDS server deployment).
HU_TC_I386    := -DCMAKE_TOOLCHAIN_FILE=/work/halflife-updated/cmake/LinuxToolchain.cmake
HU_TC_AARCH64 := -DCMAKE_TOOLCHAIN_FILE=/work/halflife-updated/cmake/LinuxToolchain-aarch64.cmake
halflife-updated-i386:
	$(call CMAKE_RECIPE,halflife-updated,i386,build-i386,$(HU_TC_I386),--target hl)
halflife-updated-amd64:
	$(call CMAKE_RECIPE,halflife-updated,amd64,build-amd64,,--target hl)
halflife-updated-aarch64:
	$(call CMAKE_RECIPE,halflife-updated,aarch64,build-aarch64,$(HU_TC_AARCH64),--target hl)
halflife-updated-all: halflife-updated-i386 halflife-updated-amd64 halflife-updated-aarch64

# --- ReHLDS (cmake) -------------------------------------------------
# i386 is upstream's default. amd64 needs -DBUILD_AMD64=ON. aarch64
# uses the toolchain file (selected by the CMakeLists' arch detection).
REHLDS_TC_AARCH64 := -DCMAKE_TOOLCHAIN_FILE=/work/ReHLDS/cmake/aarch64-linux-gnu.toolchain.cmake
rehlds-i386:
	$(call CMAKE_RECIPE,ReHLDS,i386,build-i386,,)
rehlds-amd64:
	$(call CMAKE_RECIPE,ReHLDS,amd64,build-amd64,-DBUILD_AMD64=ON,)
rehlds-aarch64:
	$(call CMAKE_RECIPE,ReHLDS,aarch64,build-aarch64,$(REHLDS_TC_AARCH64),)
rehlds-all: rehlds-i386 rehlds-amd64 rehlds-aarch64

# --- aggregate -------------------------------------------------------
all: rcbot-all metamod-r-all amxmodx-all halflife-updated-all rehlds-all

# Per-arch convenience: build every project for one arch.
.PHONY: i386 amd64 aarch64
i386:    rcbot-i386    metamod-r-i386    amxmodx-i386    halflife-updated-i386    rehlds-i386
amd64:   rcbot-amd64   metamod-r-amd64   amxmodx-amd64   halflife-updated-amd64   rehlds-amd64
aarch64: rcbot-aarch64 metamod-r-aarch64 amxmodx-aarch64 halflife-updated-aarch64 rehlds-aarch64

clean:
	@echo ">>> wiping all build dirs"
	$(DOCKER_RUN) bash -lc ' \
	  rm -rf /work/rcbotold/build_i386 /work/rcbotold/build_amd64 /work/rcbotold/build_aarch64; \
	  rm -rf /work/Metamod-R/build-i386 /work/Metamod-R/build-amd64 /work/Metamod-R/build-aarch64; \
	  rm -rf /work/amxmodx/build_i386 /work/amxmodx/build_amd64 /work/amxmodx/build_aarch64; \
	  rm -rf /work/halflife-updated/build-i386 /work/halflife-updated/build-amd64 /work/halflife-updated/build-aarch64; \
	  rm -rf /work/ReHLDS/build-i386 /work/ReHLDS/build-amd64 /work/ReHLDS/build-aarch64; \
	  echo cleaned'
