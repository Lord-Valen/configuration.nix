{
  den.aspects.flatpak.nixos = {
    services.flatpak.enable = true;
    xdg.portal.enable = true;
  };

  den.aspects.flatpak.homeManager =
    { config, lib, ... }:
    {
      home.file = lib.mkIf (!config.xdg.enable) {
        ".local/share/fonts".source = "/run/current-system/sw/share/X11/fonts";
      };
      xdg.dataFile = lib.mkIf config.xdg.enable {
        "fonts".source = "/run/current-system/sw/share/X11/fonts";
      };
    };
}
