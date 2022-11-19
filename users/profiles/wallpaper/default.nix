{
  config,
  lib,
  pkgs,
  ...
}: {
  services.random-background = {
    enable = true;
    enableXinerama = true;
    imageDirectory = "%h/.config/wallpaper";
    interval = "1h";
  };

  xdg.configFile."wallpaper".source = ./wallpaper.d;
}
