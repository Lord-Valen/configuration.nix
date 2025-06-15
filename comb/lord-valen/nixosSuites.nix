{ inputs, cell }:
let
  inherit (cell) nixosProfiles userProfiles;
in
with nixosProfiles;
rec {
  remote-play = [
    steam
    moonlight
  ];

  servarr = [
    sonarr
    radarr
    readarr
    lidarr
    prowlarr
    deluge-servarr
    jellyfin-servarr
    calibre-servarr
  ];

  games = [
    steam
    retroarch
    osu
    heroic
    lutris
    liquorix
  ];

  btrfs = [
    btrfsMaintenance
    snapper
  ];

  base = [
    linux
    core
    cachix
    fonts
    gpg
    userProfiles.root
  ];
  office = [
    writing
    printing
  ];
  develop = [
    keep-outputs
    distrobox
    javascript
  ];
  pc = base ++ [
    pipewire
    networking
    yubikey
    browser
    upower
    localsend
  ];
  pc' =
    pc
    ++ develop
    ++ office
    ++ [
      chat
      userProfiles.lord-valen
      appimage
    ];

  server = base ++ [
    nginx
    networking
  ];
  desktop = pc' ++ [ kubo ];
  laptop = pc' ++ [ colemak ];
}
