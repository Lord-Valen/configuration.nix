{ config, self, ... }:
let
  inherit (config.flake) modules;
in
{
  flake.modules.nixos.weeping-willow = {
    imports = with modules.nixos; [
      syncthing
      (self.lib.importForUser "sioux" modules.homeManager.syncthing)
    ];

    services.syncthing.settings.folders = {
    };
  };
}
