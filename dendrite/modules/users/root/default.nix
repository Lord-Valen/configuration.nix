{
  lib,
  config,
  self,
  ...
}:
let
  username = "root";
  inherit (config.flake) modules;
in
{
  flake.modules = {
    nixos.${username} =
      { pkgs, ... }:
      {
        users.users.${username} = {
          initialHashedPassword = "$6$rZhNhLxPNJx.lRBn$lXAcMr7CdFgjRcN4ZMlEai2QYWMoawm6pMKrd9oFHXgWks9KBkP3p7Afj/Djj1LnCDyXbLNT5IfVNjDEUzk1p0";
          openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJlTDo77mX1eDjo5o44C9pvIt+8nOptLVJQoGr1/Ilgl" # cardno:25_313_700
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICpUIUwaDNzvZJpkhhsK/yN1DaMCqhpmDFILhXG1kfOr" # cardno:20_624_908
          ];
          shell = pkgs.nushell;
        };
        imports =
          lib.singleton
          <| self.lib.importManyForUser username [
            modules.homeManager.${username}
            modules.homeManager.nushell
          ];
      };
    homeManager.${username} = {
      # TODO: implement a transformer like hosts.nix
      imports = with modules.homeManager; [ base ];
      home = {
        inherit username;
        homeDirectory = "/${username}";
        stateVersion = lib.mkDefault "25.05";
        sessionPath = [ "$HOME/.local/bin" ];
      };
    };
  };
}
