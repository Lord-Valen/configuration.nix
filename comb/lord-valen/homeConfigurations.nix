{
  inputs,
  cell,
}: let
  inherit (cell) homeSuites homeProfiles;
in rec {
  lord-valen.imports = with homeSuites;
    with homeProfiles;
    [
      doom
      wallpaper
      xmobar
      git.valen
      shell.nushell
    ]
    ++ base;
  lord-valen-music.imports = with homeProfiles; lord-valen.imports ++ [vcv];
  nixos.imports = with homeSuites;
    with homeProfiles;
    [
      wallpaper
    ]
    ++ base;
}
