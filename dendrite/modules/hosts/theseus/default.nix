{ config, self, ... }:
let
  inherit (config.flake) modules;
in
{
  flake.modules.hosts.theseus = {
    system.stateVersion = "24.05";
    imports = with modules.nixos; [
      pc

      btrfs

      networking

      stylix
      gdm
      gnome
      pipewire

      fwupd

      yubikey
      gpg

      flatpak
      appimage

      localsend
      steam
      retroarch

      home-manager
      root
      (
        with modules.homeManager;
        self.lib.importManyForUser "root" [
          { home.stateVersion = "24.05"; }
        ]
      )
      lord-valen
      (
        with modules.homeManager;
        self.lib.importManyForUser "lord-valen" [
          {
            home.stateVersion = "24.05";
          }

          modules.homeManager."lord-valen/wallpaper"

          strawberry
          brave
          heroic
          lutris
        ]
      )
      {
        users.users.nixos = {
          initialHashedPassword = "$y$j9T$QQ6ekOvwUjMHEpiW78DbX1$F7evMbAa0tQeMXFUiwBOViSAHqe2aij3BcxbARFgU6/";
          isNormalUser = true;
          createHome = true;
        };
      }
    ];
  };
}
