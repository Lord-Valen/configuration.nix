{ config, self, ... }:
let
  inherit (config.flake) modules;
in
{
  hosts.heracles = config.flake.modules.nixos.heracles;
  flake.modules.nixos.heracles = {
    system.stateVersion = "24.05";
    imports = with modules.nixos; [
      pc

      liquorix
      btrfs
      zsa
      drone
      #rocm

      networking
      kubo

      stylix
      stylix-catppuccin-mocha
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
      {
        services.ollama.environmentVariables = {
          OLLAMA_KV_CACHE_TYPE = "q8_0";
        };
      }
      podman

      fwupd

      ratbag
      yubikey
      gpg
      tablet

      flatpak
      appimage

      localsend
      steam
      (
        { pkgs, ... }:
        {
          programs.steam.extraPackages = with pkgs; [
            wineasio
            pkgsi686Linux.pipewire.jack
          ];
        }
      )

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
          calibre
        ]
      )
    ];
  };
}
