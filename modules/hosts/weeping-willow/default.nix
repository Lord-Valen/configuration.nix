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
          { home.stateVersion = "25.11"; }
        ]
      )
      sioux
      (
        with modules.homeManager;
        self.lib.importManyForUser "sioux" [
          {
            home.stateVersion = "25.11";
          }

          brave
        ]
      )
      lord-valen
      (
        with modules.homeManager;
        self.lib.importManyForUser "lord-valen" [
          {
            home.stateVersion = "25.11";
          }

          brave
        ]
      )
    ];
  };
}
