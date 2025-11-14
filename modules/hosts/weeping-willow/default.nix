{ config, self, ... }:
let
  inherit (config.flake) modules;
in
{
  flake.modules.hosts.weeping-willow = {
    nixpkgs.hostPLatform = "x86_64-linux";
    system.stateVersion = "24.11";
    imports = with modules.nixos; [
      pc

      btrfs

      networking

      gdm
      gnome
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
