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

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:nixos/nixos-hardware";

    std = {
      url = "github:divnix/std";
      inputs = {
        blank.follows = "blank";
        nixpkgs.follows = "nixpkgs";
        arion.follows = "arion";
      };
    };

    std-data-collection = {
      url = "github:divnix/std-data-collection";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        std.follows = "std";
      };
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

    aagl-gtk-on-nix = {
      url = "github:ezKEa/aagl-gtk-on-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # TODO: Wait for random wallpaper support
    # stylix = {
    #   url = "github:danth/stylix";
    #   inputs = {
    #     nixpkgs.follows = "nixpkgs";
    #     home-manager.follows = "home-manager";

    #     flake-compat.follows = "blank";
    #   };
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
          "VCV-Rack"
        ];
    } {
      lib = std.pick self ["repo" "lib"];
      devShells = std.harvest self ["repo" "devshells"];
    } {
      nixosConfigurations = collect self "nixosConfigurations";
      colmenaConfigurations = collect self "colmenaConfigurations";
      # TODO: implement
      # nixosModules = collect self "nixosModules";
      # hmModules = collect self "homeModules";
    };
}
