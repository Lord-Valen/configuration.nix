{
  inputs,
  cell,
}: let
  inherit (inputs) hive self nixpkgs;
  inherit (hive.bootstrap.profiles) bootstrap;
  inherit (nixpkgs) lib;
in rec {
  larva = {
    bee = {
      system = "x86_64-linux";
      pkgs = nixpkgs;
    };

    imports = [bootstrap];
    nix.registry = {
      self.flake = {inherit (self) outPath;};
      configuration.to = {
        type = "github";
        owner = "Lord-Valen";
        repo = "configuration.nix";
      };
    };

    # Pre-authorized keys
    users.users = let
      keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH6sqfUwKC9nKlRbH9laeIBJjn9fDqIH57JsLFbMDAKh"
      ];
    in {
      root.openssh.authorizedKeys = {inherit keys;};
      nixos.openssh.authorizedKeys = {inherit keys;};
    };

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
  demo =
    larva
    // {
      imports = [
        ({modulesPath, ...}: {
          imports = [
            (builtins.toString modulesPath + "/installer/cd-dvd/installation-cd-graphical-gnome.nix")
          ];
        })
      ];
    };
}
