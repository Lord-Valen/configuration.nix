{
  services.greetd.enable = true;
  programs.regreet = {
    enable = true;
    settings.background = {
      path = ./_wallpaper.jpg;
      fit = "Fill";
    };
  };
}
