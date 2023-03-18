{
  inputs,
  cell,
}: let
  inherit (cell) homeProfiles;
in rec {
  base = with homeProfiles; [
    git.common
    direnv
    xdg
  ];

  lord-valen = with homeProfiles; [
    inputs.nix-doom-emacs.hmModule
    doom
    wallpaper
    git.valen
    shell.nushell
  ]
  ++ base;

  nixos = with homeProfiles; [
    wallpaper
  ]
  ++ base;

  music = with homeProfiles; [
    vcv
  ];

  xmonad = with homeProfiles; [
    xmobar
  ];
}
