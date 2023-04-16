{
  imports = [./common.nix];
  xdg.configFile."wpaperd/wallpaper.toml".text = ''
    [default]
    path = "~/.config/wallpaper/"
    duration = "30m"
  '';
}
