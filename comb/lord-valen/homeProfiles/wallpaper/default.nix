{
  inputs,
  cell,
  config,
}:
let
  inherit (inputs) nixpkgs;
  inherit (nixpkgs) formats;
  toml = formats.toml { };
in
{
  xdg.configFile."wpaperd/wallpaper.toml".source = toml.generate "wpaperd-settings" {
    default = {
      path = ./_wallpaper.d;
      duration = "30m";
    };
  };
  services.random-background = {
    interval = "30m";
    enableXinerama = true;
    imageDirectory = "%h/.config/wallpaper";
  };
}
