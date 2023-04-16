{
  imports = [./common.nix];
  xdg.configFile."wpaperd/wallpaper.toml".text = ''
    [default]
    path = "$HOME/.config/wallpaper/"
    duration = "30m"
  '';
}
