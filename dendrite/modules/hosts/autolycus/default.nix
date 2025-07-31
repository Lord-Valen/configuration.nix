{ config, self, ... }:
let
  inherit (config.flake) modules;
in
{
  flake.modules.hosts.autolycus = {
    system.stateVersion = "24.11";
    imports = with modules.nixos; [
      liquorix
      btrfs

      networking

      stylix
      gdm
      gnome
      pipewire

      fwupd
      keepOutputs

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
      lord-valen
      (
        with modules.homeManager;
        self.lib.importManyForUser "lord-valen" [
          {
            home.stateVersion = "24.11";
          }

          modules.homeManager."lord-valen/wallpaper"
          easyeffects

          vscode
          emacs
          notes
          brave
          tor
          musescore
        ]
      )
    ];
  };
}
