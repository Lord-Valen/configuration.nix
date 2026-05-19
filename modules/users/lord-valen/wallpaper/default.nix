{
  den.aspects.wallpaper.provides.lord-valen = {
    homeManager =
      { pkgs, ... }:
      {
        xdg.configFile."wpaperd/wallpaper.toml".source =
          (pkgs.formats.toml { }).generate "wpaperd-settings"
            {
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
  };
}
