{
  inputs,
  cell,
}: let
  inherit (cell) homeSuites homeProfiles;
in {
  lord-valen = {
    # inherit bee home;
    imports = with homeSuites;
    with homeProfiles;
      [
        doom
        wallpaper
        xmobar
        git.valen
        shell.nushell
      ]
      ++ base;
  };
}
