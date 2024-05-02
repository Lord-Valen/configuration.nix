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
      "osu-lazer-bin"
    ];
}
