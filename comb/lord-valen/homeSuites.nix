{ inputs, cell }:
let
  inherit (cell) homeProfiles;
in
rec {
  base = with homeProfiles; [
    core
    shell
    git
    helix
    zathura
    less
    gpg
  ];

  cosmetic = with homeProfiles; [
    face
    wallpaper
    stylix
  ];

  apps = with homeProfiles; [
    appimage
  ];

  development = with homeProfiles; [
    gitbutler
    devenv
    emacs
    vscode
  ];

  download = with homeProfiles; [
    aria2
  ];

  audio = with homeProfiles; [
    easyeffects
  ];

  video = with homeProfiles; [
    mpv
  ];

  music =
    with homeProfiles;
    audio
    ++ [
      vcv
      strawberry
    ];

  games = with homeProfiles; [
    lutris
    opentrack
  ];

  full = inputs.nixpkgs.lib.concatLists [
    base
    cosmetic
    development
    music
    apps
    download
    games
  ];

  laptop = with homeProfiles; [ colemak ];

  hyprland = with homeProfiles; [ homeProfiles.hyprland ];

  xmonad = with homeProfiles; [ xmobar ];
}
