{ config, self, ... }:
let
  inherit (config.flake) modules;
in
{
  flake.modules.hosts.weeping-willow = {
    nixpkgs.hostPlatform = "x86_64-linux";
    system.stateVersion = "25.11";
    imports = with modules.nixos; [
      pc

      btrfs

      networking

      gdm
      gnome
      kde
      cosmic
      pipewire

      fwupd
      upgrade

      flatpak
      appimage

      localsend

      writing
      printing

      home-manager
      root
      (
        with modules.homeManager;
        self.lib.importManyForUser "root" [
          { home.stateVersion = "24.05"; }
        ]
      )
      sioux
      (
        with modules.homeManager;
        self.lib.importManyForUser "sioux" [
          {
            home.stateVersion = "24.11";
          }

          brave
          localsend
        ]
      )
    ];
  };
}
