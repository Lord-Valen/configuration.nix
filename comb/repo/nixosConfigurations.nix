{ inputs, cell }:
let
  inherit (inputs.hive.bootstrap.profiles) bootstrap;
  inherit (cell) pkgs;
  inherit (pkgs) lib;
in
# TODO: Use haumea
rec {
  larva = {
    bee = {
      system = "x86_64-linux";
      pkgs = pkgs;
    };
    nixpkgs.flake.source = inputs.nixpkgs-unstable.outPath;

    # FIXME: https://github.com/divnix/hive/issues/38
    # imports = [ bootstrap ];
    nix.registry = {
      configuration.to = {
        type = "github";
        owner = "Lord-Valen";
        repo = "configuration.nix";
      };
    };

    # Pre-authorized keys
    users.users =
      let
        keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJlTDo77mX1eDjo5o44C9pvIt+8nOptLVJQoGr1/Ilgl" # cardno:25_313_700
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICpUIUwaDNzvZJpkhhsK/yN1DaMCqhpmDFILhXG1kfOr" # cardno:20_624_908
        ];
      in
      {
        root.openssh.authorizedKeys = {
          inherit keys;
        };
        nixos.openssh.authorizedKeys = {
          inherit keys;
        };
      };

    services.fwupd.enable = true;

    # Use iwd
    networking = {
      networkmanager = {
        enable = true;
        wifi.backend = "iwd";
      };

      wireless = {
        enable = lib.mkForce false;
        iwd.enable = true;
      };
    };
  };

  # Give me the same thing with a GNOME environment to show people
  demo = larva // {
    imports = [
      # FIXME: https://github.com/divnix/hive/issues/38
      # (
      #   { modulesPath, ... }:
      #   {
      #     imports = [
      #       (builtins.toString modulesPath + "/installer/cd-dvd/installation-cd-graphical-gnome.nix")
      #     ];
      #   }
      # )
    ];
  };
}
