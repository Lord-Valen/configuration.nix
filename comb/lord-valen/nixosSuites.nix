{ inputs, cell }:
let
  inherit (cell) nixosProfiles userProfiles;
in
rec {
  remote-play = with nixosProfiles; [
    steam
    moonlight
  ];

  servarr = with nixosProfiles; [
    nixosProfiles.servarr
    sonarr
    radarr
    readarr
    lidarr
    prowlarr
    deluge-servarr
    jellyfin-servarr
    calibre-servarr
  ];

  games = with nixosProfiles; [
    steam
    retroarch
    osu
    heroic
    lutris
    liquorix
  ];

  btrfs = with nixosProfiles; [
    btrfsMaintenance
    snapper
  ];

  base = with nixosProfiles; [
    linux
    core
    cachix
    fonts
    gpg
    userProfiles.root
    fwupd
  ];
  office = with nixosProfiles; [
    writing
    printing
  ];
  develop = with nixosProfiles; [
    keep-outputs
    distrobox
    javascript
  ];
  pc =
    base
    ++ (with nixosProfiles; [
      pipewire
      networking
      yubikey
      browser
      upower
      localsend
    ]);
  pc' =
    pc
    ++ develop
    ++ office
    ++ (with nixosProfiles; [
      chat
      userProfiles.lord-valen
      appimage
    ]);

  server =
    base
    ++ (with nixosProfiles; [
      nginx
      networking
    ]);
  desktop = pc' ++ (with nixosProfiles; [ kubo ]);
  laptop = pc' ++ (with nixosProfiles; [ colemak ]);
}
