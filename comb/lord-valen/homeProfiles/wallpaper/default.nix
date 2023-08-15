{
  inputs,
  cell,
  config,
}: let
  inherit (inputs) nixpkgs;
  inherit (nixpkgs) lib;
in {
  xdg.configFile."wallpaper".source = ./_wallpaper.d;
  xdg.configFile."wpaperd/wallpaper.toml".text = ''
    [default]
    path = "~/.config/wallpaper/"
    duration = "30m"
  '';
  services.random-background = {
    interval = "30m";
    enableXinerama = true;
    imageDirectory = "%h/.config/wallpaper";
  };
}
