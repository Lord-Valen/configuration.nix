{
  description = "Lord-Valen's NixOS Configurations";

  nixConfig = {
    extra-experimental-features = "nix-command flakes";

    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://nrdxp.cachix.org"
    ];

    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "nrdxp.cachix.org-1:Fc5PSqY2Jm1TrWfm88l6cvGWwz3s93c6IOifQWnhNW4="
    ];
  };

  inputs = {
    blank.url = "github:divnix/blank";

    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    nixos-hardware.url = "github:nixos/nixos-hardware";

    std = {
      url = "github:divnix/std";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.arion.follows = "arion";
    };

    std-data-collection = {
      url = "github:divnix/std-data-collection";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.std.follows = "std";
    };

    hive = {
      url = "github:divnix/hive";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
        colmena.follows = "colmena";
        nixos-generators.follows = "nixos-generators";
      };
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-22.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    colmena = {
      url = "github:zhaofengli/colmena";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-compat.follows = "blank";
    };

    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixlib.follows = "nixpkgs";
    };

    arion = {
      url = "github:hercules-ci/arion";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-doom-emacs = {
      url = "github:nix-community/nix-doom-emacs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # aagl-gtk-on-nix = {
    #   url = "github:ezKEa/aagl-gtk-on-nix/271df5673a4bda398d2bc3ef5d5bb2f6868e2988";
    #   flake = false;
    # };
  };

  outputs = {
    self,
    hive,
    std,
    ...
  } @ inputs: let
    # I don't need to worry about name collisions.
    # If you think you might, don't do this.
    collect = hive.collect // {renamer = cell: target: "${target}";};
    lib = inputs.nixpkgs.lib // builtins;
  in
    hive.growOn {
      inherit inputs;

      cellsFrom = ./comb;
      cellBlocks = with std.blockTypes;
      with hive.blockTypes; [
        # library
        (functions "lib")

        # modules
        (functions "nixosModules")
        (functions "homeModules")

        # profiles
        (functions "hardwareProfiles")
        (functions "nixosProfiles")
        (functions "homeProfiles")

        # suites
        (functions "nixosSuites")
        (functions "homeSuites")

        # configurations
        nixosConfigurations
        homeConfigurations
        colmenaConfigurations

        # pkgs
        (pkgs "pkgs")

        # devshells
        (devshells "devshells")
      ];

      # I want to keep proprietary software to a minimum.
      # allowUnfreePredicate forces me to keep track of what proprietary software I allow.
      nixpkgsConfig.allowUnfreePredicate = pkg:
        lib.elem (lib.getName pkg) [
          "discord"
          "hplip"
          "steam"
          "steam-run"
          "steam-original"
        ];
    }
    {
      lib = std.pick self ["_queen" "lib"];
      devShells = std.harvest self ["_queen" "devshells"];
    }
    {
      nixosConfigurations = collect self "nixosConfigurations";
      homeConfigurations = collect self "homeConfigurations";
      colmenaConfigurations = collect self "colmenaConfigurations";
    };
}
