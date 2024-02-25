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
    ];

    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI="
      "colmena.cachix.org-1:7BzpDnjjH8ki2CT3f6GdOk7QAzPOl+1t3LvTLXqYcSg="
    ];
  };

  inputs = {
    nixpkgs-stable.url = "https://flakehub.com/f/NixOS/nixpkgs/*.tar.gz";
    nixpkgs-unstable.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1.0.tar.gz";
    nixpkgs.follows = "nixpkgs-stable";
    #nixpkgs.follows = "nixpkgs-unstable";
    nixpkgs'.follows = "nixpkgs";

    home-manager = {
      url = "https://flakehub.com/f/nix-community/home-manager/*.tar.gz";
      #url = "https://flakehub.com/f/nix-community/home-manager/0.1.*.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
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
      url = "github:divnix/hive/05facc4307d7aca173e46825f572bca72ea0c775";
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
      url = "github:nix-community/disko/5d9f362aecd7a4c2e8a3bf2afddb49051988cab9";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    anyrun = {
      url = "github:Kirottu/anyrun";
    };
  };

  # Desktop
  inputs = {
    aagl-gtk-on-nix.url = "github:ezKEa/aagl-gtk-on-nix";
    aagl-gtk-on-nix.inputs.flake-compat.follows = "";

    nix-doom-emacs.url = "github:nix-community/nix-doom-emacs";
    nix-doom-emacs.inputs.flake-compat.follows = "";

    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    # TODO: Wait for random wallpaper support
    # stylix = {
    #   url = "github:danth/stylix";
    #   inputs = {
    #     nixpkgs.follows = "nixpkgs";
    #     home-manager.follows = "home-manager";
    #     flake-compat.follows = "";
    #   };
    # };

    watershot.url = "github:Kirottu/watershot/v0.2.0";
    watershot.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      hive,
      std,
      ...
    }@inputs:
    let
      # I don't need to worry about name collisions.
      # If you think you might, don't do this.
      myCollect = hive.collect // {
        renamer = cell: target: "${target}";
      };
      lib = inputs.nixpkgs.lib // builtins;
    in
    hive.growOn
      {
        inherit inputs;

        cellsFrom = ./comb;
        cellBlocks =
          with std.blockTypes;
          with hive.blockTypes;
          [
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
            (pkgs "pkgs")
          ];

        # I want to keep proprietary software to a minimum.
        # allowUnfreePredicate forces me to keep track of what proprietary software I allow.
        nixpkgsConfig.allowUnfreePredicate =
          pkg:
          lib.elem (lib.getName pkg) [
            "steam"
            "steam-run"
            "steam-original"
            "VCV-Rack"
            "osu-lazer-bin-2023.1114.1"
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
        colmenaHive = myCollect self "colmenaConfigurations";
        # TODO: implement
        # nixosModules = collect self "nixosModules";
        # hmModules = collect self "homeModules";
      };
}
