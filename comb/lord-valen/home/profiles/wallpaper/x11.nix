{
  imports = [./common.nix];
  services.random-background = {
    interval = "30m";
    enable = true;
    enableXinerama = true;
    imageDirectory = "%h/.config/wallpaper";
  };
}
