{ den, ... }:
{
  den.aspects.weeping-willow = {
    includes = with den.aspects; [
      root
      appimage

      pc
      btrfs

      networking

      sddm
      kde
      cosmic
      pipewire

      fwupd
      upgrade
      upgradeReboot

      flatpak

      localsend

      writing
      printing
    ];

    nixos = {
      nixpkgs.hostPlatform = "x86_64-linux";
      system.stateVersion = "25.11";
    };

    to-users.homeManager.home.stateVersion = "25.11";

    provides.lord-valen = {
      includes = with den.aspects; [ brave ];
    };

    provides.sioux = {
      includes = with den.aspects; [
        brave
        calibre
      ];
    };
  };
}
