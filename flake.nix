{
  description = "Lord-Valen's NixOS Configurations";

  nixConfig = {
    extra-experimental-features = "nix-command flakes";

    extra-substituters = [
      # nix-community
      "https://nix-community.cachix.org"
      # aagl
      "https://ezkea.cachix.org"
      # colmena
      "https://colmena.cachix.org"
      # cosmic
      "https://cosmic.cachix.org"
    ];

    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI="
      "colmena.cachix.org-1:7BzpDnjjH8ki2CT3f6GdOk7QAzPOl+1t3LvTLXqYcSg="
      "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
    ];
  };

  inputs = {
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs.follows = "nixpkgs-stable";

    home-manager-stable = {
      url = "github:/nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    home-manager-unstable = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    home-manager.follows = "home-manager-stable";

    stylix = {
      url = "github:danth/stylix/release-24.05";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
        flake-compat.follows = "";
      };
    };

    nixos-hardware.url = "github:nixos/nixos-hardware";

    devshell.url = "github:numtide/devshell";
    nixago.url = "github:nix-community/nixago";
    nixago.inputs.nixpkgs.follows = "nixpkgs";
    std = {
      url = "github:divnix/std";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        arion.follows = "arion";
        devshell.follows = "devshell";
        devshell.inputs.nixpkgs.follows = "nixpkgs";
        nixago.follows = "nixago";
      };
    };

    colmena.url = "https://flakehub.com/f/zhaofengli/colmena/0.4.0.tar.gz";
    colmena.inputs.flake-compat.follows = "";
    hive = {
      url = "github:divnix/hive/e7e3873da470a2a8ed267e2ab492129ff780579b";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        colmena.follows = "colmena";
      };
    };

    arion = {
      url = "github:hercules-ci/arion";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko/v1.3.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-cosmic.url = "github:lilyinstarlight/nixos-cosmic";
  };

  # Desktop
  inputs = {
    anyrun.url = "github:anyrun-org/anyrun";

    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      hive,
      std,
      ...
    }@inputs:
    let
      inherit (inputs.nixpkgs-unstable) lib;

      # I don't need to worry about name collisions.
      # If you think you might, don't do this.
      myCollect = hive.collect // {
        renamer = cell: target: "${target}";
      };
    in
    hive.growOn
      {
        inherit inputs;

        cellsFrom = ./comb;
        cellBlocks =
          with (lib.mergeAttrsList [
            std.blockTypes
            hive.blockTypes
          ]); [
            # bee module
            (functions "bee")

            # colmena profile
            (functions "deployment")

            # modules
            (functions "nixosModules")
            (functions "homeModules")

            # profiles
            (functions "hardwareProfiles")
            (functions "nixosProfiles")
            (functions "userProfiles")
            (functions "arionProfiles")
            (functions "homeProfiles")

            # suites
            (functions "nixosSuites")
            (functions "homeSuites")

            # configurations
            nixosConfigurations
            diskoConfigurations
            colmenaConfigurations

            # devshells
            (nixago "configs")
            (devshells "devshells")

            # packages
            (installables "packages")

            # nixpkgs
            (functions "nixpkgsConfig")
            (pkgs "pkgs")
            (pkgs "pkgs-stable")
            (pkgs "pkgs-unstable")
          ];
      }
      {
        devShells = std.harvest self [
          "repo"
          "devshells"
        ];
        packages = std.harvest self [
          "lord-valen"
          "packages"
        ];
      }
      {
        nixosConfigurations = myCollect self "nixosConfigurations";
        homeConfigurations = myCollect self "homeConfigurations";
        diskoConfigurations = myCollect self "diskoConfigurations";
        colmenaHive = myCollect self "colmenaConfigurations";
        # TODO: implement
        # nixosModules = collect self "nixosModules";
        # hmModules = collect self "homeModules";
      };
}
