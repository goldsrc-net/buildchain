# Upstream ecosystem

Inventory of every component the buildchain plugs into, organized by
layer.  goldsrc-net forks track an `64bit` branch off each upstream's
default and are pinned by SHA in this repo's `.gitmodules`.

## Layer 1 — Engine

| Path / our fork | Upstream | Role | 64-bit status |
|---|---|---|---|
| `./ReHLDS` → [`goldsrc-net/ReHLDS`](https://github.com/goldsrc-net/ReHLDS) | [rehlds/ReHLDS](https://github.com/rehlds/ReHLDS) | Reverse-engineered HLDS engine 8684.  The 64-bit port target. | ✅ `3.15.0.944-64bit` |
| (reference) | [FWGS/xash3d-fwgs](https://github.com/FWGS/xash3d-fwgs) | Alternative GoldSrc-compatible engine — already 64-bit-clean; useful as an ABI sanity reference. | ✅ (upstream) |

## Layer 2 — Plugin / extension framework

| Path / our fork | Upstream | Role | 64-bit status |
|---|---|---|---|
| `./Metamod-R` → [`goldsrc-net/Metamod-R`](https://github.com/goldsrc-net/Metamod-R) | [rehlds/Metamod-R](https://github.com/rehlds/Metamod-R) | Plugin loader; hooks engine ↔ gameplay-DLL boundary.  Required for amxmodx. | ✅ `1.3.0.192-64bit` |
| `./amxmodx` → [`goldsrc-net/amxmodx`](https://github.com/goldsrc-net/amxmodx) | [alliedmodders/amxmodx](https://github.com/alliedmodders/amxmodx) | Scripting / admin / plugin framework on top of Metamod. | ✅ `1.10.0.5513-64bit` |
| `./rcbotold` → [`goldsrc-net/rcbotold`](https://github.com/goldsrc-net/rcbotold) | [APGRoboCop/rcbotold](https://github.com/APGRoboCop/rcbotold) | Bot framework, runs as a Metamod plugin. | ✅ `v1.51b14-64bit` |

## Layer 3 — Gameplay DLLs (twhl-community "updated" line)

Modern, bug-fixed forks of the official Half-Life 1 SDK.  Canonical
for HL / Op4 / BS modding.

| Path / our fork | Upstream | Mod | 64-bit status |
|---|---|---|---|
| `./halflife-updated` → [`goldsrc-net/halflife-updated`](https://github.com/goldsrc-net/halflife-updated) | [twhl-community/halflife-updated](https://github.com/twhl-community/halflife-updated) | valve (Half-Life) | ✅ `HLU-V1.1.0-64bit-demo` |
| — | [twhl-community/halflife-op4-updated](https://github.com/twhl-community/halflife-op4-updated) | gearbox (Opposing Force) | TBD |
| — | [twhl-community/halflife-bs-updated](https://github.com/twhl-community/halflife-bs-updated) | bshift (Blue Shift) | TBD |
| — | [twhl-community/halflife-unified-sdk](https://github.com/twhl-community/halflife-unified-sdk) | HL + Op4 + BS merged into one tree | TBD |
| — | [twhl-community/dmc-updated](https://github.com/twhl-community/dmc-updated) | dmc (Deathmatch Classic) | TBD |
| — | [twhl-community/ricochet-updated](https://github.com/twhl-community/ricochet-updated) | ricochet | TBD |

## Layer 3 — Gameplay DLLs (rehlds line)

Reverse-engineered gameplay code for mods Valve never publicly
source-released.

| Path / our fork | Upstream | Mod | 64-bit status |
|---|---|---|---|
| — | [rehlds/ReGameDLL_CS](https://github.com/rehlds/ReGameDLL_CS) | cstrike (Counter-Strike 1.6 + CZ) | TBD |
| (local-only) | none — bootstrapped from a copy of `ReGameDLL_CS` on 2026-05-08, pre-RE.  See `~/Packages/ReGameDLL_TFC/CLAUDE.md`. | tfc (Team Fortress Classic) | TBD (no upstream yet) |

## Layer 3 — Gameplay DLLs (alliedmodders line)

| Path / our fork | Upstream | Role | 64-bit status |
|---|---|---|---|
| `./hlsdk` → [`goldsrc-net/hlsdk`](https://github.com/goldsrc-net/hlsdk) | [alliedmodders/hlsdk](https://github.com/alliedmodders/hlsdk) | AlliedModders' HL SDK fork, used as the build base by amxmodx modules. | ✅ (consumed via amxmodx pin) |

## Layer 4 — Build / CI infrastructure

| Path / our fork | Upstream | Role |
|---|---|---|
| `./build-containers` → [`goldsrc-net/build-containers`](https://github.com/goldsrc-net/build-containers) | [alliedmodders/build-containers](https://github.com/alliedmodders/build-containers) | Base docker images for the buildchain (`debian10`, `debian11` variants) plus the four consumer-repo CI runners. |
| `./metamod-hl1` (header source) | [alliedmodders/metamod-hl1](https://github.com/alliedmodders/metamod-hl1) | Classic-layout `meta_api.h` source for amxmodx's `detectMetamod` probe (header-only consumption; we don't link against this binary). |

## Build-chain dependency graph

```
                    ┌──────────────────┐
                    │     ReHLDS       │  ← engine (Layer 1)
                    └────────┬─────────┘
                             │ engine ABI
                    ┌────────▼─────────┐
                    │    Metamod-R     │  ← plugin loader (Layer 2)
                    └──┬───────────┬───┘
                       │           │
              ┌────────▼──┐    ┌───▼─────┐
              │  amxmodx  │    │ rcbotold│  ← plugins (Layer 2)
              └───────────┘    └─────────┘
                       │
                       │ loads
                       ▼
        ┌──────────────────────────────────────┐
        │        gameplay DLLs (Layer 3)       │
        │ ┌───────────┐ ┌─────────────────────┐│
        │ │  twhl line│ │     rehlds line     ││
        │ │ HL/Op4/BS │ │   CS / (TFC pending)││
        │ │  DMC/Rico │ │                     ││
        │ └───────────┘ └─────────────────────┘│
        └──────────────────────────────────────┘
```

To deliver a working 64-bit dedicated server for any given mod,
every layer above it must be 64-bit.  ABI must agree across the
engine ↔ Metamod ↔ gameplay-DLL boundary — type-width fixes can't
be made unilaterally on one side.

## Port-order recommendation

1. ✅ **`halflife-updated`** — done.  The canonical HL gameplay DLL.
   Patches landed here (function-pointer ABI, `MAKE_STRING` via
   `ALLOC_STRING`, weapon-bits sync) recur in every other
   gameplay project and form the reference patch set.
2. ✅ **`ReHLDS`** — done.  64-bit engine; without it, no gameplay-DLL
   port is testable end-to-end against a real server.
3. ✅ **`Metamod-R`** — done.  Unblocks amxmodx / rcbotold.
4. ✅ **`amxmodx`** + **`rcbotold`** — done.  Ported after their
   direct dependencies.
5. **Other twhl gameplay DLLs** (`op4`, `bshift`, `dmc`, `ricochet`,
   or `unified-sdk` instead of separate op4/bshift) — apply the
   `halflife-updated` patch set with mod-specific touch-ups.
6. **`ReGameDLL_CS`** — separate codebase but conceptually similar
   64-bit fixes.
7. **`ReGameDLL_TFC`** — long tail; needs the upstream RE work first;
   the port comes "for free" once it shares the patch set.

`xash3d-fwgs` is already 64-bit-clean and serves as a reference
target — if a port works under Xash3D but not under ReHLDS, that's
diagnostic info about what ReHLDS still needs.

## Conventions

- Each project keeps its upstream `master` (or default) branch clean
  and tracks a `64bit` branch for the port.  halflife-updated also
  tracks `64bit-demo` (= `64bit` + 1 demo-only commit lifting the
  `UTIL_IsValveGameDirectory` gate so `hl.so` can act as the valve
  gamedll for the showcase deploy).
- Cross-project patches that share a logical motivation should
  reference each other in commit messages (`see halflife-updated@<sha>`)
  so the patch set is navigable later.
- 64-bit gotchas worth a per-project NOTES are: function-pointer ABI
  widening, `string_t` / `int` confusion via `MAKE_STRING`,
  `cd->weapons` width vs. `m_WeaponBits`, struct padding in shared
  types crossing the engine boundary.
- Buildchain consumers ride the `64bit` branch; this repo pins their
  SHAs in `.gitmodules`.  See `scripts/verify-pins.sh` for the
  green-CI provenance check.
