{ config, self, ... }:
let
  inherit (config.flake) modules;
in
{
  flake.modules.hosts.autolycus = {
    system.stateVersion = "24.11";
    imports = with modules.nixos; [
      btrfs

      networking

      gdm
      gnome
      pipewire

      colemak
      yubikey
      gpg

      localsend

      photography

      home-manager
      lord-valen
      (
        with modules.homeManager;
        self.lib.importManyForUser "lord-valen" [
          {
            home.stateVersion = "24.11";
          }
          vscode
          emacs
        ]
      )
    ];
  };
}
