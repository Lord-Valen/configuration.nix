{ den, ... }:
{
  den.aspects.heracles = {
    includes = with den.aspects; [
      development
      audio
      appimage
      gpg
      photography
      wallpaper

      pc
      xanmod
      btrfs
      zsa
      drone

      sops

      networking
      kubo
      aria2

      stylix
      stylix-catppuccin-mocha

      sddm
      kde
      cosmic
      pipewire
      ollama
      podman

      fwupd

      ratbag
      yubikey
      tablet

      flatpak

      localsend
      steam

      writing
      printing
    ];

    nixos =
      { pkgs, ... }:
      {
        system.stateVersion = "24.05";
        stylix.targets.qt.enable = false;
        services.ollama.environmentVariables.OLLAMA_KV_CACHE_TYPE = "q8_0";
        programs.steam.extraPackages = with pkgs; [
          wineasio
          pkgsi686Linux.pipewire.jack
        ];
      };

    to-users.homeManager.home.stateVersion = "24.05";

    provides.lord-valen = {
      includes = with den.aspects; [
        easyeffects
        musescore
        strawberry
        vscode
        emacs
        notes
        brave
        tor
        chat
        thunderbird
        zathura
        heroic
        lutris
        calibre
        vcv
      ];
      homeManager = {
        stylix.targets.qt.enable = false;
      };
    };
  };
}
