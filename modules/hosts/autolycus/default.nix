{ config, self, ... }:
let
  inherit (config.flake) modules;
in
{
  hosts.autolycus = config.flake.modules.nixos.autolycus;
  flake.modules.nixos.autolycus = {
    system.stateVersion = "24.11";
    imports = with modules.nixos; [
      pc

      liquorix
      btrfs

      networking
      kubo

      stylix

      sddm
      kde
      {
        # FIXME: "https://github.com/nix-community/stylix/issues/1092"
        stylix.targets.qt.enable = false;
      }
      # gdm
      # gnome
      pipewire

      fwupd

      colemak
      yubikey
      gpg
      tablet

      flatpak
      appimage

      localsend
      steam

      audio
      development
      writing
      printing
      photography

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
            home.stateVersion = "24.11";
          }

          {
            # FIXME: "https://github.com/nix-community/stylix/issues/1092"
            stylix.targets.qt.enable = false;
          }

          modules.homeManager."lord-valen/wallpaper"
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
        ]
      )
    ];
  };
}
