# OpenRGB config

`gta6.json` is a profile saved from the OpenRGB GUI. The live copy is
`/var/lib/OpenRGB/profiles/gta6.json`, and the `openrgb` service overwrites
it with this file on every start (see `modules/nixos/openrgb`).

## Syncing GUI changes

When the user changes the profile in the GUI, copy the live file here, then
clean it:

1. Remove every controller with `"vendor": "Logitech"`. The G305 mouse is
   not managed by OpenRGB, and its detector is disabled in `default.nix`.
2. Delete `colors` from both `ENE DRAM` controllers.
3. Set every entry of the ASRock controller's `colors` to `0`.
4. Keep the GPU's `colors` as saved.

```sh
jq --indent 4 '
  .controllers |= map(select(.vendor != "Logitech"))
  | .controllers |= map(
      if .name == "ENE DRAM" then del(.colors)
      elif .vendor == "ASRock" then .colors |= map(0)
      else . end)' gta6.json > gta6.json.tmp && mv gta6.json.tmp gta6.json
```

The cleaning is done when `git diff` shows only the changes the user made.
Check it with numeric-only lines filtered out:
`git diff gta6.json | rg '^[-+]' | rg -v '^[-+]\s+[0-9]+,?$'`.

## Why the per-controller `colors` are cleaned

The gradient lives in the effects plugin section
(`plugins."OpenRGB Effects Plugin".Effects[0].CustomSettings.colors`).
Each controller's `colors` array is a snapshot of the LEDs at save time, and
the running `CustomGradientWave` effect changes them 60 times a second, so
every GUI save produces a different, meaningless diff.

OpenRGB 1.1 treats `colors` as optional. When applying a profile, it copies
the array only if its length equals the device's LED count, and otherwise
leaves the LEDs alone. The array is per controller, so one zone can't be
kept without the rest.

- The effect drives every DRAM LED, so DRAM needs no `colors`.
- The effect drives ASRock zones 0, 1, 2 and 4 and overwrites them after
  load. Zone 3 (PCB) is outside the effect, and it stays off only because
  its `colors` entries are `0`. Dropping the ASRock array would turn the PCB
  lights back on.
- The GPU runs its own hardware mode outside the effect, so its saved color
  is real state.

If the user adds a zone to the effect, or removes one, re-check which LEDs
rely on saved colors before running the jq command above.
