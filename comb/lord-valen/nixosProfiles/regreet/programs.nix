{ inputs, cell }:
{
  regreet = {
    enable = true;
    package = cell.pkgs-unstable.greetd.regreet;
    settings.background = {
      path = ./_wallpaper.jpg;
      fit = "Fill";
    };
  };
}
