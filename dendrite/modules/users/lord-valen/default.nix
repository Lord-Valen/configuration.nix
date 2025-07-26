{ config, ... }:
let
  username = "lord-valen";
in
{
  flake.modules = {
    nixos.${username} =
      { pkgs, ... }:
      {
        imports = with config.flake.modules.nixos; [
          home-manager
        ];
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
          home-manager.users.lord-valen.imports = with config.flake.modules.home-manager; [
            config.flake.modules.home-manager.${username}
            nushell
          ];
        };
      };
    homeManager.${username} =
      {
        lib,
        ...
      }:
      {
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
