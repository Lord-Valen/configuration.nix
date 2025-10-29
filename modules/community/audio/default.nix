{ config, ... }:
let
  inherit (config.flake) modules;
in
{
  flake.modules.nixos.audio = { };
  flake.modules.homeManager.audio = {
    imports = with modules.homeManager; [
      zrythm
      plugins

      supercollider
      vcv
      guitarix
    ];
  };
}
