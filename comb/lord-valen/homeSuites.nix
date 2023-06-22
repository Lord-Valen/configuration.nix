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
      shell
      doom
      face
    ]
    ++ base;

  nixos = base;

  music = with homeProfiles; [
    vcv
  ];

  hyprland = with homeProfiles; [
    homeProfiles.hyprland
    wallpaper.wayland
  ];

  xmonad = with homeProfiles; [
    xmobar
    wallpaper.x11
  ];
}
