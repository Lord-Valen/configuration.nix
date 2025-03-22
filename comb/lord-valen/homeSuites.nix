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
      gitbutler
      shell
      emacs
      vscode
      helix
      face
      wallpaper
      zathura
      less
      mpv
      stylix
      appimage
      aria2
      easyeffects
    ]
    ++ base;

  music = with homeProfiles; [
    vcv
    mpd
    strawberry
  ];

  hyprland = with homeProfiles; [ homeProfiles.hyprland ];

  xmonad = with homeProfiles; [ xmobar ];
}
