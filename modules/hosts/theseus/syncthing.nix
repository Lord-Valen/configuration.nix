{ config, self, ... }:
let
  inherit (config.flake) modules;
in
{
  flake.modules.nixos.theseus = {
    imports = with modules.nixos; [
      syncthing
    ];

    services.syncthing.settings.folders = {
      "Pythia Bup" = {
        id = "jtafu-4mn0y";
        path = "/data/pythia-bup";
        type = "receiveonly";
        devices = [
          "Autolycus"
          "Heracles"
          "Pythia"
        ];
      };
      "Pythia Photos" = {
        id = "pixel_7_n835-photos";
        path = "/data/pythia-photos";
        type = "receiveonly";
        devices = [
          "Autolycus"
          "Heracles"
          "Pythia"
        ];
      };
      "Books" = {
        id = "fheng-o2wyn";
        path = "/data/media/books";
        type = "sendonly";
        devices = [
          "lvHeracles"
          "Pythia"
        ];
      };
      "Music" = {
        id = "zfumc-pfy38";
        path = "/data/media/music";
        type = "sendonly";
        devices = [
          "Pythia"
        ];
      };
    };
  };
}
