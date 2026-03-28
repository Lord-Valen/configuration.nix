{ config, ... }:
let
  inherit (config.flake) modules;
in
{
  flake.aspects.audio = {
    nixos = {
      imports = with modules.nixos; [
        browser-audio
      ];
    };
    homeManager = {
      imports = with modules.homeManager; [
        zrythm
        plugins

        supercollider
        vcv
        guitarix
      ];
    };
  };
}
