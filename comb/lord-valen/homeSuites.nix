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
    eww
    homeProfiles.hyprland
    wallpaper.wayland
  ];

  xmonad = with homeProfiles; [
    xmobar
    wallpaper.x11
  ];
}
