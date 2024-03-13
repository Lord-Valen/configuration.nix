{
  inputs,
  cell,
  config,
  pkgs,
}:
let
  # FIXME: attribute 'pkgs' missing
  pkgs = inputs.nixpkgs;
  toml = pkgs.formats.toml { };
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
