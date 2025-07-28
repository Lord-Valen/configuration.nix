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

      gdm
      gnome
      pipewire

      fwupd
      keepOutputs

      colemak
      yubikey
      gpg

      localsend

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
          vscode
          emacs
        ]
      )
    ];
  };
}
