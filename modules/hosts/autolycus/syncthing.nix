{ den, ... }:
{
  den.aspects.autolycus = {
    includes = with den.aspects; [ syncthing ];
    nixos.services.syncthing.settings.folders = {
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
    provides.lord-valen.includes = with den.aspects; [ syncthing ];
  };
}
