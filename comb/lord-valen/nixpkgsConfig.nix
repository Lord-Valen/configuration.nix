{ inputs, cell }:
let
  inherit (inputs.nixpkgs) lib;
in
{
  # I want to keep proprietary software to a minimum.
  # allowUnfreePredicate forces me to keep track of what proprietary software I allow.
  allowUnfreePredicate =
    pkg:
    lib.elem (lib.getName pkg) [
      "steam"
      "steam-run"
      "steam-original"
      "vcv-rack"
      "osu-lazer-bin-2024.312.1"
      # TODO: slim down retroarch cores
      "libretro-fbalpha2012"
      "libretro-fbneo"
      "libretro-fmsx"
      "libretro-genesis-plus-gx"
      "libretro-mame2000"
      "libretro-mame2003"
      "libretro-mame2003-plus"
      "libretro-mame2010"
      "libretro-mame2015"
      "libretro-opera"
      "libretro-picodrive"
      "libretro-snes9x"
      "libretro-snes9x2002"
      "libretro-snes9x2005"
      "libretro-snes9x2005-plus"
      "libretro-snes9x2010"
    ];
}
