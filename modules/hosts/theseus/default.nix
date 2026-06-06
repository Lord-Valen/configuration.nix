{ den, ... }:
{
  den.aspects.theseus = {
    includes = with den.aspects; [
      appimage
      gpg
      wallpaper

      pc
      btrfs

      networking

      stylix
      stylix-catppuccin-mocha

      sddm
      kde
      pipewire

      fwupd
      upgrade
      upgradeReboot

      yubikey

      flatpak

      localsend
      steam
      retroarch

      sops

      prometheus
      grafana
      caddy
      cloudflare
      stationeers
    ];

    nixos = {
      system.stateVersion = "24.05";
      system.autoUpgrade.dates = "weekly";
    };

    to-users.homeManager.home.stateVersion = "24.05";

    provides.lord-valen = {
      includes = with den.aspects; [
        strawberry
        brave
        heroic
        lutris
      ];
    };
  };

  den.aspects.nixos = {
    includes = [ den.batteries.define-user ];
    user.initialHashedPassword = "$y$j9T$QQ6ekOvwUjMHEpiW78DbX1$F7evMbAa0tQeMXFUiwBOViSAHqe2aij3BcxbARFgU6/";
  };
}
