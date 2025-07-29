{
  flake.modules.homeManager."lord-valen/wallpaper" =
    {
      pkgs,
      ...
    }:
    let
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
        imageDirectory = ./_wallpaper.d;
      };
    };
}
