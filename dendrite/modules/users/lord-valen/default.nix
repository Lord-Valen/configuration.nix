{
  lib,
  config,
  self,
  ...
}:
let
  username = "lord-valen";
  inherit (config.flake) modules;
in
{
  flake.modules = {
    nixos.${username} =
      { pkgs, ... }:
      {
        users.users.${username} = {
          initialHashedPassword = "$6$nVSlPb7ImRaYAkid$xMyn6KfAw1r9KqOZrZB8ldfk5zNZSU7U/QKST.M218dkzxGbXLf/7RzQflpH.csU6vubGG21QqRRqv8yKrsdb0";
          isNormalUser = true;
          createHome = true;
          # extraGroups = [
          #   "adbusers"
          #   "libvirtd"
          #   "networkmanager"
          #   "wheel"
          #   "audio"
          #   "wireshark"
          #   config.services.kubo.group
          # ];
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
            modules.homeManager.comma
          ];
      };
    homeManager.${username} = {
      # TODO: implement a transformer like hosts.nix
      imports = with modules.homeManager; [ base ];
      home = {
        inherit username;
        homeDirectory = "/home/${username}";
        stateVersion = lib.mkDefault "25.05";
        sessionPath = [ "$HOME/.local/bin" ];
      };
      xdg = {
        enable = true;
        userDirs = {
          enable = true;
          createDirectories = true;
        };
        configFile."nixpkgs/config.nix".source = ./_config.nix;
      };
    };
  };
}
