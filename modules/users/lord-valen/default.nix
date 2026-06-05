{ lib, den, ... }:
{
  den.aspects.lord-valen = {
    includes = [
      den.batteries.define-user
      den.batteries.primary-user
      den.aspects.base
      den.aspects.nushell
    ];

    user =
      { pkgs, osConfig, ... }:
      {
        initialHashedPassword = "$6$nVSlPb7ImRaYAkid$xMyn6KfAw1r9KqOZrZB8ldfk5zNZSU7U/QKST.M218dkzxGbXLf/7RzQflpH.csU6vubGG21QqRRqv8yKrsdb0";
        shell = pkgs.nushell;
        extraGroups = [
          "libvirtd"
          "wireshark"
        ]
        ++ lib.optional osConfig.services.kubo.enable osConfig.services.kubo.group;
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJlTDo77mX1eDjo5o44C9pvIt+8nOptLVJQoGr1/Ilgl" # cardno:25_313_700
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICpUIUwaDNzvZJpkhhsK/yN1DaMCqhpmDFILhXG1kfOr" # cardno:20_624_908
        ];
      };

    homeManager = {
      home = {
        stateVersion = lib.mkDefault "25.05";
        sessionPath = [ "$HOME/.local/bin" ];
        file.".face".source = ./_face.png;
      };
      xdg = {
        enable = true;
        userDirs = {
          enable = true;
          createDirectories = true;
          setSessionVariables = true;
        };
        configFile."nixpkgs/config.nix".source = ./_config.nix;
      };
    };
  };
}
