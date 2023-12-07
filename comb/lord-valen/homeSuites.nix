{
  inputs,
  cell,
}: let
  inherit (cell) homeProfiles;
in rec {
  base = with homeProfiles; [
    core
  ];

  laptop = with homeProfiles; [
    colemak
  ];

  lord-valen = with homeProfiles;
    [
      gpg
      git
      shell
      doom
      face
      wallpaper
      zathura
      less
    ]
    ++ base;

  nixos = base;

  music = with homeProfiles; [
    vcv
  ];

  hyprland = with homeProfiles; [
    homeProfiles.hyprland
  ];

  xmonad = with homeProfiles; [
    xmobar
  ];
}
