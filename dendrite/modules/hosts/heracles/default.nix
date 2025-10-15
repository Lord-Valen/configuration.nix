{ config, self, ... }:
let
  inherit (config.flake) modules;
in
{
  flake.modules.hosts.heracles = {
    system.stateVersion = "24.05";
    imports = with modules.nixos; [
      pc

      liquorix
      btrfs
      zsa

      networking
      kubo

      stylix
      gdm
      gnome
      pipewire
      ollama
      podman

      fwupd
      keepOutputs

      ratbag
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
            home.stateVersion = "24.05";
          }

          modules.homeManager."lord-valen/wallpaper"
          easyeffects

          music
          strawberry
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
        ]
      )
    ];
  };
}
