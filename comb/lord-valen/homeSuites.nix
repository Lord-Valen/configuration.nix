{ inputs, cell }:
let
  inherit (cell) homeProfiles;
in
rec {
  base = with homeProfiles; [ core ];

  laptop = with homeProfiles; [ colemak ];

  lord-valen =
    with homeProfiles;
    [
      gpg
      git
      shell
      doom
      face
      wallpaper
      zathura
      less
      mpv
    ]
    ++ base;

  nixos = base;

  music = with homeProfiles; [
    vcv
    mpd
  ];

  hyprland = with homeProfiles; [ homeProfiles.hyprland ];

  xmonad = with homeProfiles; [ xmobar ];
}
