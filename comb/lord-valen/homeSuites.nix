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

  laptop = with homeProfiles; [
    colemak
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
    wallpaper.wayland
    eww
  ];

  xmonad = with homeProfiles; [
    xmobar
    wallpaper.x11
  ];
}
