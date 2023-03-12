{
  inputs,
  cell,
}: let
  inherit (cell) homeSuites homeProfiles;
in {
  lord-valen = {
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
