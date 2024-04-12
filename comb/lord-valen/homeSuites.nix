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
      helix
      face
      wallpaper
      zathura
      less
      mpv
      stylix
      appimage
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
