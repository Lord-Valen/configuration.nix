{ config, self, ... }:
let
  inherit (config.flake) modules;
in
{
  flake.modules.hosts.weeping-willow = {
    imports = with modules.nixos; [
      syncthing
      (self.lib.importForUser "sioux" modules.homeManager.syncthing)
    ];

    services.syncthing.settings.folders = {
    };
  };
}
