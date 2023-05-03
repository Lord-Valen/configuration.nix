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
      git.valen
      shell.nushell
      doom
    ]
    ++ base;

  nixos = base;

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
