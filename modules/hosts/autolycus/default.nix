{ den, ... }:
{
  den.aspects.autolycus = {
    includes = with den.aspects; [
      development
      audio
      appimage
      gpg
      photography
      wallpaper

      pc
      btrfs
      nixos-facter
      disko
      sops

      networking
      kubo
      aria2

      stylix
      stylix-catppuccin-mocha

      sddm
      kde
      pipewire

      fwupd
      secureBoot

      colemak
      yubikey
      tablet

      flatpak

      localsend
      steam

      writing
      printing
    ];

    nixos = {
      system.stateVersion = "24.11";
      stylix.targets.qt.enable = false;
    };

    to-users.homeManager.home.stateVersion = "24.11";

    provides.lord-valen = {
      includes = with den.aspects; [
        easyeffects
        vscode
        emacs
        notes
        brave
        tor
        musescore
        chat
        zathura
        heroic
        lutris
        calibre
      ];
      homeManager = {
        stylix.targets.qt.enable = false;
      };
    };
  };
}
