{ config, self, ... }:
let
  inherit (config.flake) modules;
in
{
  flake.modules.host.autolycus = {
    imports = with modules.nixos; [
      syncthing
      (self.lib.importForUser "lord-valen" modules.homeManager.syncthing)
    ];

    services.syncthing.settings.folders = {
      "Pythia Bup" = {
        id = "jtafu-4mn0y";
        path = "~/pythia-bup";
        type = "receiveonly";
        devices = [
          "Heracles"
          "Theseus"
          "Pythia"
        ];
      };
      "Pythia Photos" = {
        id = "pixel_7_n835-photos";
        path = "~/pythia-photos";
        type = "receiveonly";
        devices = [
          "Heracles"
          "Theseus"
          "Pythia"
        ];
      };
    };
  };
}
