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

  lord-valen = with homeProfiles;
    [
      gpg
      wallpaper
      git.valen
      shell.nushell

      inputs.nix-doom-emacs.hmModule
      doom
    ]
    ++ base;

  nixos = with homeProfiles;
    [
      wallpaper
    ]
    ++ base;

  music = with homeProfiles; [
    vcv
  ];

  hyprland = with homeProfiles; [
    wayland.hyprland
  ];

  xmonad = with homeProfiles; [
    xmobar
  ];
}
