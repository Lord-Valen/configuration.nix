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
      rocm

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
      cosmic
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

          {
            # FIXME: "https://github.com/nix-community/stylix/issues/1092"
            stylix.targets.qt.enable = false;
          }

          modules.homeManager."lord-valen/wallpaper"
          easyeffects

          musescore
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
