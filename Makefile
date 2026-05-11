# hlds64-buildchain orchestrator
#
# Verb-first target shape. Three verbs (build / clean / deploy), four
# qualifier shapes (none / project / arch / project+arch), composed as
# the verb prefix on a hyphen.
#
#   build                  global: every project × every arch        (15 builds)
#   build-rcbot            project: every arch of one project        (3 builds)
#   build-i386             arch:    every project for one arch       (5 builds)
#   build-rcbot-i386       project+arch: most specific               (1 build)
#
# Mirrors apply to clean and deploy:
#
#   clean                  wipe every build dir
#   clean-rcbot            wipe just rcbotold/build_*
#   clean-i386             wipe every project's i386 build dir
#   clean-rcbot-i386       wipe rcbotold/build_i386
#
#   deploy                 stage built binaries to every rig (3 local
#                          + pleb remote)
#   deploy-rcbot           ship one project to every rig
#   deploy-i386            ship every project for one arch to the
#                          matching local rig (~/Containers/hlds/hlds-linux32-test/)
#   deploy-amd64           ~/Containers/hlds/hlds-linux64-test/
#   deploy-aarch64         ~/Containers/hlds/hlds-arm64/
#   deploy-pleb            scp+rsync the aarch64 stack to pleb@10.23.23.80
#   deploy-rcbot-aarch64   one project, one rig (most specific)
#
# Source repos default to the buildchain dir (submodules at ./<repo>/);
# override with SRC_ROOT=$HOME/Packages to build from your live local
# trees, or with per-project paths (RCBOT_PATH, AMXMODX_PATH, etc.).
#
#   make build                                # build everything
#   make build SRC_ROOT=$HOME/Packages        # build from Packages
#   make build-amxmodx-aarch64                # one project, one arch
#   make deploy                               # ship to all rigs
#   make image                                # rebuild docker image
#   make clean && make build                  # full from-scratch

# --- configuration --------------------------------------------------

IMAGE      := hlds64-buildchain:debian12

SRC_ROOT   ?= $(CURDIR)
RCBOT      := $(or $(RCBOT_PATH),$(SRC_ROOT)/rcbotold)
METAMODR   := $(or $(METAMODR_PATH),$(SRC_ROOT)/Metamod-R)
METAMOD_HL1 := $(or $(METAMOD_HL1_PATH),$(SRC_ROOT)/metamod-hl1)
AMXMODX    := $(or $(AMXMODX_PATH),$(SRC_ROOT)/amxmodx)
HLSDK      := $(or $(HLSDK_PATH),$(SRC_ROOT)/hlsdk)
HALFLIFE   := $(or $(HALFLIFE_PATH),$(SRC_ROOT)/halflife-updated)
REHLDS     := $(or $(REHLDS_PATH),$(SRC_ROOT)/ReHLDS)

# Where each project's build outputs are read from during `make deploy`.
# Defaults match the build-from-source locations under the active SRC_ROOT.
RCBOT_BUILD     ?= $(RCBOT)
METAMODR_BUILD  ?= $(METAMODR)
AMXMODX_BUILD   ?= $(AMXMODX)
HALFLIFE_BUILD  ?= $(HALFLIFE)
REHLDS_BUILD    ?= $(REHLDS)

# Deploy targets.
RIG_I386     ?= $(HOME)/Containers/hlds/hlds-linux32-test
RIG_AMD64    ?= $(HOME)/Containers/hlds/hlds-linux64-test
RIG_AARCH64  ?= $(HOME)/Containers/hlds/hlds-arm64
PLEB_HOST    ?= 10.23.23.80
PLEB_PATH    ?= /opt/hlds

DOCKER     := docker
# BuildKit on this host (Docker Desktop 29.4.2) intermittently fails to
# fetch apt indexes during `docker build` despite `docker run` working
# fine. The legacy builder is reliable.
DOCKER_BUILD := DOCKER_BUILDKIT=0 $(DOCKER) build

VOLS := \
  -v $(RCBOT):/work/rcbotold \
  -v $(METAMODR):/work/Metamod-R \
  -v $(METAMOD_HL1):/work/metamod-hl1 \
  -v $(AMXMODX):/work/amxmodx \
  -v $(HLSDK):/work/hlsdk \
  -v $(HALFLIFE):/work/halflife-updated \
  -v $(REHLDS):/work/ReHLDS

# Submodule .git access: when SRC_ROOT is the buildchain dir (default),
# each consumer project's ./.git is a gitlink FILE pointing at
# $(SRC_ROOT)/.git/modules/<name>/ via a relative path
# ("gitdir: ../.git/modules/<name>"). Inside the container that
# relative path resolves to /work/.git/modules/<name>/, which doesn't
# exist by default. Bind-mount it where the gitlink expects so
# AMBuild's version-string probe (git rev-list, .git/HEAD reads) sees
# the real gitdir and embeds an actual commit count + sha. The
# scripts under amxmodx/support/ also fail-open if the gitdir isn't
# present (e.g., when building from a tarball or in a fresh clone
# without the parent gitdir), but mounting it gives us real version
# strings whenever the submodule layout is available.
GITDIR_ROOT := $(SRC_ROOT)/.git/modules
GIT_VOLS := \
  $(if $(wildcard $(GITDIR_ROOT)/rcbotold/HEAD),-v $(GITDIR_ROOT)/rcbotold:/work/.git/modules/rcbotold:ro,) \
  $(if $(wildcard $(GITDIR_ROOT)/Metamod-R/HEAD),-v $(GITDIR_ROOT)/Metamod-R:/work/.git/modules/Metamod-R:ro,) \
  $(if $(wildcard $(GITDIR_ROOT)/amxmodx/HEAD),-v $(GITDIR_ROOT)/amxmodx:/work/.git/modules/amxmodx:ro,) \
  $(if $(wildcard $(GITDIR_ROOT)/halflife-updated/HEAD),-v $(GITDIR_ROOT)/halflife-updated:/work/.git/modules/halflife-updated:ro,) \
  $(if $(wildcard $(GITDIR_ROOT)/ReHLDS/HEAD),-v $(GITDIR_ROOT)/ReHLDS:/work/.git/modules/ReHLDS:ro,)

VOLS += $(GIT_VOLS)

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

# Project and arch enumerations — drive the per-tuple target generation
# below so adding a project or an arch only requires touching one list.
PROJECTS := rcbot metamod-r amxmodx halflife-updated rehlds
ARCHES   := i386 amd64 aarch64

# Map short project tag to the actual source dir name (mostly the same
# except rcbot → rcbotold).
SRCDIR_rcbot            := rcbotold
SRCDIR_metamod-r        := Metamod-R
SRCDIR_amxmodx          := amxmodx
SRCDIR_halflife-updated := halflife-updated
SRCDIR_rehlds           := ReHLDS

# Build dir name pattern (build_<arch> for AMBuild, build-<arch> for cmake).
BUILDDIR_rcbot            := build_
BUILDDIR_metamod-r        := build-
BUILDDIR_amxmodx          := build_
BUILDDIR_halflife-updated := build-
BUILDDIR_rehlds           := build-

# --- helpers --------------------------------------------------------

# Generic ambuild build pattern. Args: $1=src dir name, $2=arch, $3=extra configure flags
#
# Incremental by design: only ensures the build dir exists, then
# (re-)configures and builds. AMBuild detects existing state and
# rebuilds only what changed. Force a full rebuild via `clean-X`.
define AMBUILD_RECIPE
@echo ">>> $(1) ($(2))"
$(DOCKER_RUN) bash -lc 'set -e; \
  mkdir -p /work/$(1)/build_$(2); \
  cd /work/$(1)/build_$(2); \
  $(ENV_$(2)) ambuild-python /work/$(1)/configure.py --target-arch=$(2) $(3); \
  ambuild'
endef

# Generic cmake build pattern. Args: $1=src dir name, $2=arch, $3=build dir suffix,
# $4=extra cmake configure flags, $5=optional --target arg.
#
# Same incremental design as AMBUILD_RECIPE. CMake's idempotent
# configure refreshes only what changed.
define CMAKE_RECIPE
@echo ">>> $(1) ($(2))"
$(DOCKER_RUN) bash -lc 'set -e; \
  mkdir -p /work/$(1)/$(3); \
  cd /work/$(1)/$(3); \
  $(ENV_$(2)) cmake -S /work/$(1) -B . -DCMAKE_BUILD_TYPE=Release $(4); \
  cmake --build . -j$$(nproc) $(5)'
endef

# --- build-<proj>-<arch> — the 15 most-specific build targets -------

build-rcbot-i386:           ; $(call AMBUILD_RECIPE,rcbotold,i386,)
build-rcbot-amd64:          ; $(call AMBUILD_RECIPE,rcbotold,amd64,)
build-rcbot-aarch64:        ; $(call AMBUILD_RECIPE,rcbotold,aarch64,)

build-metamod-r-i386:       ; $(call CMAKE_RECIPE,Metamod-R,i386,build-i386,,)
build-metamod-r-amd64:      ; $(call CMAKE_RECIPE,Metamod-R,amd64,build-amd64,-DBUILD_64BIT=ON,)
build-metamod-r-aarch64:    ; $(call CMAKE_RECIPE,Metamod-R,aarch64,build-aarch64,-DCMAKE_TOOLCHAIN_FILE=/work/Metamod-R/cmake/toolchain-aarch64-linux.cmake,)

AMXMODX_FLAGS := --metamod=/work/metamod-hl1 --hlsdk=/work/hlsdk --mysql=system
build-amxmodx-i386:         ; $(call AMBUILD_RECIPE,amxmodx,i386,$(AMXMODX_FLAGS))
build-amxmodx-amd64:        ; $(call AMBUILD_RECIPE,amxmodx,amd64,$(AMXMODX_FLAGS))
build-amxmodx-aarch64:      ; $(call AMBUILD_RECIPE,amxmodx,aarch64,$(AMXMODX_FLAGS))

HU_TC_I386    := -DCMAKE_TOOLCHAIN_FILE=/work/halflife-updated/cmake/LinuxToolchain.cmake
HU_TC_AARCH64 := -DCMAKE_TOOLCHAIN_FILE=/work/halflife-updated/cmake/LinuxToolchain-aarch64.cmake
build-halflife-updated-i386:    ; $(call CMAKE_RECIPE,halflife-updated,i386,build-i386,$(HU_TC_I386),--target hl)
build-halflife-updated-amd64:   ; $(call CMAKE_RECIPE,halflife-updated,amd64,build-amd64,,--target hl)
build-halflife-updated-aarch64: ; $(call CMAKE_RECIPE,halflife-updated,aarch64,build-aarch64,$(HU_TC_AARCH64),--target hl)

REHLDS_TC_AARCH64 := -DCMAKE_TOOLCHAIN_FILE=/work/ReHLDS/cmake/aarch64-linux-gnu.toolchain.cmake
build-rehlds-i386:          ; $(call CMAKE_RECIPE,ReHLDS,i386,build-i386,,)
build-rehlds-amd64:         ; $(call CMAKE_RECIPE,ReHLDS,amd64,build-amd64,-DBUILD_AMD64=ON,)
build-rehlds-aarch64:       ; $(call CMAKE_RECIPE,ReHLDS,aarch64,build-aarch64,$(REHLDS_TC_AARCH64),)

# --- build-<proj> — per-project aggregate ---------------------------

build-rcbot:            build-rcbot-i386            build-rcbot-amd64            build-rcbot-aarch64
build-metamod-r:        build-metamod-r-i386        build-metamod-r-amd64        build-metamod-r-aarch64
build-amxmodx:          build-amxmodx-i386          build-amxmodx-amd64          build-amxmodx-aarch64
build-halflife-updated: build-halflife-updated-i386 build-halflife-updated-amd64 build-halflife-updated-aarch64
build-rehlds:           build-rehlds-i386           build-rehlds-amd64           build-rehlds-aarch64

# --- build-<arch> — per-arch aggregate ------------------------------

build-i386:    build-rcbot-i386    build-metamod-r-i386    build-amxmodx-i386    build-halflife-updated-i386    build-rehlds-i386
build-amd64:   build-rcbot-amd64   build-metamod-r-amd64   build-amxmodx-amd64   build-halflife-updated-amd64   build-rehlds-amd64
build-aarch64: build-rcbot-aarch64 build-metamod-r-aarch64 build-amxmodx-aarch64 build-halflife-updated-aarch64 build-rehlds-aarch64

# --- build — global aggregate ---------------------------------------
# Default goal. `make` with no args runs this.

.DEFAULT_GOAL := build
build: build-rcbot build-metamod-r build-amxmodx build-halflife-updated build-rehlds

# --- clean ----------------------------------------------------------
# clean-<proj>-<arch> wipes one build dir. Aggregates compose from there.

define CLEAN_RECIPE
@echo ">>> clean $(1) ($(2))"
$(DOCKER_RUN) bash -lc 'rm -rf /work/$(1)/$(BUILDDIR_$(3))$(2)'
endef

clean-rcbot-i386:               ; $(call CLEAN_RECIPE,rcbotold,i386,rcbot)
clean-rcbot-amd64:              ; $(call CLEAN_RECIPE,rcbotold,amd64,rcbot)
clean-rcbot-aarch64:            ; $(call CLEAN_RECIPE,rcbotold,aarch64,rcbot)
clean-metamod-r-i386:           ; $(call CLEAN_RECIPE,Metamod-R,i386,metamod-r)
clean-metamod-r-amd64:          ; $(call CLEAN_RECIPE,Metamod-R,amd64,metamod-r)
clean-metamod-r-aarch64:        ; $(call CLEAN_RECIPE,Metamod-R,aarch64,metamod-r)
clean-amxmodx-i386:             ; $(call CLEAN_RECIPE,amxmodx,i386,amxmodx)
clean-amxmodx-amd64:            ; $(call CLEAN_RECIPE,amxmodx,amd64,amxmodx)
clean-amxmodx-aarch64:          ; $(call CLEAN_RECIPE,amxmodx,aarch64,amxmodx)
clean-halflife-updated-i386:    ; $(call CLEAN_RECIPE,halflife-updated,i386,halflife-updated)
clean-halflife-updated-amd64:   ; $(call CLEAN_RECIPE,halflife-updated,amd64,halflife-updated)
clean-halflife-updated-aarch64: ; $(call CLEAN_RECIPE,halflife-updated,aarch64,halflife-updated)
clean-rehlds-i386:              ; $(call CLEAN_RECIPE,ReHLDS,i386,rehlds)
clean-rehlds-amd64:             ; $(call CLEAN_RECIPE,ReHLDS,amd64,rehlds)
clean-rehlds-aarch64:           ; $(call CLEAN_RECIPE,ReHLDS,aarch64,rehlds)

clean-rcbot:            clean-rcbot-i386            clean-rcbot-amd64            clean-rcbot-aarch64
clean-metamod-r:        clean-metamod-r-i386        clean-metamod-r-amd64        clean-metamod-r-aarch64
clean-amxmodx:          clean-amxmodx-i386          clean-amxmodx-amd64          clean-amxmodx-aarch64
clean-halflife-updated: clean-halflife-updated-i386 clean-halflife-updated-amd64 clean-halflife-updated-aarch64
clean-rehlds:           clean-rehlds-i386           clean-rehlds-amd64           clean-rehlds-aarch64

clean-i386:    clean-rcbot-i386    clean-metamod-r-i386    clean-amxmodx-i386    clean-halflife-updated-i386    clean-rehlds-i386
clean-amd64:   clean-rcbot-amd64   clean-metamod-r-amd64   clean-amxmodx-amd64   clean-halflife-updated-amd64   clean-rehlds-amd64
clean-aarch64: clean-rcbot-aarch64 clean-metamod-r-aarch64 clean-amxmodx-aarch64 clean-halflife-updated-aarch64 clean-rehlds-aarch64

clean: clean-rcbot clean-metamod-r clean-amxmodx clean-halflife-updated clean-rehlds

# --- deploy ---------------------------------------------------------
# Stages built binaries into the local test rigs (~/Containers/hlds/)
# or, for pleb, scp+rsync to the production aarch64 server. All file
# movement (paths, plumbing, plugins.ini / liblist.gam edits) is
# delegated to ./scripts/deploy.sh so per-arch path quirks stay in
# one place.
#
# Each rig deploys files into valve/ — there's NO halflife_updated/
# mod dir; the halflife-updated hl.so binary goes straight into
# valve/dlls/. liblist.gam's gamedll_linux is wired to
# addons/metamod/dlls/metamod_<arch>.so and plugins.ini lists amxmodx
# + rcbot for metamod to load.
#
# Invocation: deploy.sh <project|all> <mode> <arch> <target> <build-root>
# project: rcbot | metamod-r | amxmodx | halflife-updated | rehlds | all
# mode:    local | remote   (remote uses rsync over ssh)
# arch:    i386 | amd64 | aarch64
# target:  local path, OR for remote: host:path

DEPLOY := ./scripts/deploy.sh

# --- deploy-<proj>-<arch> — the 20 most-specific deploy targets ----
# (5 projects × 4 rigs: 3 local arches + pleb)

deploy-rcbot-i386:                 ; $(DEPLOY) rcbot            local  i386    $(RIG_I386)             $(RCBOT_BUILD)
deploy-rcbot-amd64:                ; $(DEPLOY) rcbot            local  amd64   $(RIG_AMD64)            $(RCBOT_BUILD)
deploy-rcbot-aarch64:              ; $(DEPLOY) rcbot            local  aarch64 $(RIG_AARCH64)          $(RCBOT_BUILD)
deploy-rcbot-pleb:                 ; $(DEPLOY) rcbot            remote aarch64 $(PLEB_HOST):$(PLEB_PATH) $(RCBOT_BUILD)

deploy-metamod-r-i386:             ; $(DEPLOY) metamod-r        local  i386    $(RIG_I386)             $(METAMODR_BUILD)
deploy-metamod-r-amd64:            ; $(DEPLOY) metamod-r        local  amd64   $(RIG_AMD64)            $(METAMODR_BUILD)
deploy-metamod-r-aarch64:          ; $(DEPLOY) metamod-r        local  aarch64 $(RIG_AARCH64)          $(METAMODR_BUILD)
deploy-metamod-r-pleb:             ; $(DEPLOY) metamod-r        remote aarch64 $(PLEB_HOST):$(PLEB_PATH) $(METAMODR_BUILD)

deploy-amxmodx-i386:               ; $(DEPLOY) amxmodx          local  i386    $(RIG_I386)             $(AMXMODX_BUILD)
deploy-amxmodx-amd64:              ; $(DEPLOY) amxmodx          local  amd64   $(RIG_AMD64)            $(AMXMODX_BUILD)
deploy-amxmodx-aarch64:            ; $(DEPLOY) amxmodx          local  aarch64 $(RIG_AARCH64)          $(AMXMODX_BUILD)
deploy-amxmodx-pleb:               ; $(DEPLOY) amxmodx          remote aarch64 $(PLEB_HOST):$(PLEB_PATH) $(AMXMODX_BUILD)

deploy-halflife-updated-i386:      ; $(DEPLOY) halflife-updated local  i386    $(RIG_I386)             $(HALFLIFE_BUILD)
deploy-halflife-updated-amd64:     ; $(DEPLOY) halflife-updated local  amd64   $(RIG_AMD64)            $(HALFLIFE_BUILD)
deploy-halflife-updated-aarch64:   ; $(DEPLOY) halflife-updated local  aarch64 $(RIG_AARCH64)          $(HALFLIFE_BUILD)
deploy-halflife-updated-pleb:      ; $(DEPLOY) halflife-updated remote aarch64 $(PLEB_HOST):$(PLEB_PATH) $(HALFLIFE_BUILD)

deploy-rehlds-i386:                ; $(DEPLOY) rehlds           local  i386    $(RIG_I386)             $(REHLDS_BUILD)
deploy-rehlds-amd64:               ; $(DEPLOY) rehlds           local  amd64   $(RIG_AMD64)            $(REHLDS_BUILD)
deploy-rehlds-aarch64:             ; $(DEPLOY) rehlds           local  aarch64 $(RIG_AARCH64)          $(REHLDS_BUILD)
deploy-rehlds-pleb:                ; $(DEPLOY) rehlds           remote aarch64 $(PLEB_HOST):$(PLEB_PATH) $(REHLDS_BUILD)

# --- deploy-<proj> — same project across every rig ------------------

deploy-rcbot:            deploy-rcbot-i386            deploy-rcbot-amd64            deploy-rcbot-aarch64            deploy-rcbot-pleb
deploy-metamod-r:        deploy-metamod-r-i386        deploy-metamod-r-amd64        deploy-metamod-r-aarch64        deploy-metamod-r-pleb
deploy-amxmodx:          deploy-amxmodx-i386          deploy-amxmodx-amd64          deploy-amxmodx-aarch64          deploy-amxmodx-pleb
deploy-halflife-updated: deploy-halflife-updated-i386 deploy-halflife-updated-amd64 deploy-halflife-updated-aarch64 deploy-halflife-updated-pleb
deploy-rehlds:           deploy-rehlds-i386           deploy-rehlds-amd64           deploy-rehlds-aarch64           deploy-rehlds-pleb

# --- deploy-<arch> — every project to one rig -----------------------

deploy-i386:    deploy-rcbot-i386    deploy-metamod-r-i386    deploy-amxmodx-i386    deploy-halflife-updated-i386    deploy-rehlds-i386
deploy-amd64:   deploy-rcbot-amd64   deploy-metamod-r-amd64   deploy-amxmodx-amd64   deploy-halflife-updated-amd64   deploy-rehlds-amd64
deploy-aarch64: deploy-rcbot-aarch64 deploy-metamod-r-aarch64 deploy-amxmodx-aarch64 deploy-halflife-updated-aarch64 deploy-rehlds-aarch64
deploy-pleb:    deploy-rcbot-pleb    deploy-metamod-r-pleb    deploy-amxmodx-pleb    deploy-halflife-updated-pleb    deploy-rehlds-pleb

# --- deploy — global ------------------------------------------------

deploy: deploy-i386 deploy-amd64 deploy-aarch64 deploy-pleb

# --- misc -----------------------------------------------------------

image:
	$(DOCKER_BUILD) --platform=linux/amd64 -t $(IMAGE) .

shell:
	$(DOCKER) run --rm -it --platform=linux/amd64 \
	  --user $(shell id -u):$(shell id -g) \
	  $(VOLS) -w /work \
	  $(IMAGE)

help:
	@echo 'hlds64-buildchain — verb-first target shape.'
	@echo ''
	@echo 'Usage: make [target] [VAR=value ...]'
	@echo ''
	@echo 'Verbs: build clean deploy   (image, shell, help also)'
	@echo ''
	@echo 'Targets compose as <verb>[-<project>][-<arch>]:'
	@echo '  make build                       # everything (5 projects × 3 arches)'
	@echo '  make build-<project>             # one project, every arch'
	@echo '  make build-<arch>                # every project, one arch'
	@echo '  make build-<project>-<arch>      # one project, one arch'
	@echo ''
	@echo '  make clean[-<project>][-<arch>]  # wipe build dirs, same shape'
	@echo ''
	@echo '  make deploy                      # ship to every rig'
	@echo '  make deploy-<project>            # one project, every rig'
	@echo '  make deploy-<arch>               # every project, one local rig'
	@echo '  make deploy-pleb                 # every project, remote pleb'
	@echo '  make deploy-<project>-<arch>     # one project, one local rig'
	@echo '  make deploy-<project>-pleb       # one project, remote pleb'
	@echo ''
	@echo 'Projects: rcbot, metamod-r, amxmodx, halflife-updated, rehlds'
	@echo 'Arches:   i386, amd64, aarch64'
	@echo 'Rigs:     i386 → ~/Containers/hlds/hlds-linux32-test/'
	@echo '          amd64 → ~/Containers/hlds/hlds-linux64-test/'
	@echo '          aarch64 → ~/Containers/hlds/hlds-arm64/'
	@echo '          pleb → 10.23.23.80:/opt/hlds  (rsync over ssh)'
	@echo ''
	@echo 'Other:'
	@echo '  make image                       # rebuild the docker image'
	@echo '  make shell                       # interactive shell in the image'
	@echo '  make help                        # this message'
	@echo ''
	@echo 'Variables (defaults shown for reference):'
	@echo '  SRC_ROOT=$$(CURDIR)              parent of source trees'
	@echo '  RCBOT_PATH / METAMODR_PATH / AMXMODX_PATH / HALFLIFE_PATH / REHLDS_PATH'
	@echo '                                    per-project source override'
	@echo '  RIG_I386 / RIG_AMD64 / RIG_AARCH64   local rig dir override'
	@echo '  PLEB_HOST=10.23.23.80   PLEB_PATH=/opt/hlds   remote target'
	@echo ''
	@echo 'Examples:'
	@echo '  make                                       # default: build'
	@echo '  make build-rehlds-aarch64                  # one tuple'
	@echo '  make build SRC_ROOT=$$HOME/Packages         # build from Packages'
	@echo '  make clean-amxmodx && make build-amxmodx   # full amxmodx rebuild'
	@echo '  make deploy-aarch64                        # stage everything to the arm64 rig'
	@echo '  make deploy-rcbot                          # ship rcbot to every rig'

# --- phony declarations --------------------------------------------

.PHONY: image shell help build clean deploy
.PHONY: build-rcbot build-metamod-r build-amxmodx build-halflife-updated build-rehlds
.PHONY: build-rcbot-i386 build-rcbot-amd64 build-rcbot-aarch64
.PHONY: build-metamod-r-i386 build-metamod-r-amd64 build-metamod-r-aarch64
.PHONY: build-amxmodx-i386 build-amxmodx-amd64 build-amxmodx-aarch64
.PHONY: build-halflife-updated-i386 build-halflife-updated-amd64 build-halflife-updated-aarch64
.PHONY: build-rehlds-i386 build-rehlds-amd64 build-rehlds-aarch64
.PHONY: build-i386 build-amd64 build-aarch64
.PHONY: clean-rcbot clean-metamod-r clean-amxmodx clean-halflife-updated clean-rehlds
.PHONY: clean-rcbot-i386 clean-rcbot-amd64 clean-rcbot-aarch64
.PHONY: clean-metamod-r-i386 clean-metamod-r-amd64 clean-metamod-r-aarch64
.PHONY: clean-amxmodx-i386 clean-amxmodx-amd64 clean-amxmodx-aarch64
.PHONY: clean-halflife-updated-i386 clean-halflife-updated-amd64 clean-halflife-updated-aarch64
.PHONY: clean-rehlds-i386 clean-rehlds-amd64 clean-rehlds-aarch64
.PHONY: clean-i386 clean-amd64 clean-aarch64
.PHONY: deploy-rcbot deploy-metamod-r deploy-amxmodx deploy-halflife-updated deploy-rehlds
.PHONY: deploy-rcbot-i386 deploy-rcbot-amd64 deploy-rcbot-aarch64 deploy-rcbot-pleb
.PHONY: deploy-metamod-r-i386 deploy-metamod-r-amd64 deploy-metamod-r-aarch64 deploy-metamod-r-pleb
.PHONY: deploy-amxmodx-i386 deploy-amxmodx-amd64 deploy-amxmodx-aarch64 deploy-amxmodx-pleb
.PHONY: deploy-halflife-updated-i386 deploy-halflife-updated-amd64 deploy-halflife-updated-aarch64 deploy-halflife-updated-pleb
.PHONY: deploy-rehlds-i386 deploy-rehlds-amd64 deploy-rehlds-aarch64 deploy-rehlds-pleb
.PHONY: deploy-i386 deploy-amd64 deploy-aarch64 deploy-pleb
