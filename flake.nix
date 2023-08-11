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
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs.follows = "nixpkgs-stable";
    nixpkgs'.follows = "nixpkgs";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:nixos/nixos-hardware";

    devshell.url = "github:numtide/devshell";
    nixago.url = "github:nix-community/nixago";
    nixago.inputs.nixpkgs.follows = "nixpkgs";
    std = {
      url = "github:divnix/std/80e5792eae98353a97ab1e85f3fba2784e4a3690";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        arion.follows = "arion";
        devshell.follows = "devshell";
        devshell.inputs.nixpkgs.follows = "nixpkgs";
        nixago.follows = "nixago";
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
        disko.follows = "disko";
        colmena.follows = "colmena";
        nixos-generators.follows = "nixos-generators";
      };
    };

    colmena = {
      url = "github:zhaofengli/colmena/v0.4.0";
      inputs.flake-compat.follows = "";
    };

    nixos-generators = {
      url = "github:nix-community/nixos-generators/1.7.0";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixlib.follows = "nixpkgs";
    };

    arion = {
      url = "github:hercules-ci/arion";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko/5d9f362aecd7a4c2e8a3bf2afddb49051988cab9";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # Desktop
  inputs = {
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    nix-doom-emacs.url = "github:nix-community/nix-doom-emacs";
    nix-doom-emacs.inputs.emacs-overlay.follows = "emacs-overlay";
    nix-doom-emacs.inputs.flake-compat.follows = "";

    aagl-gtk-on-nix.url = "github:ezKEa/aagl-gtk-on-nix";
    aagl-gtk-on-nix.inputs.flake-compat.follows = "";

    watershot.url = "github:Kirottu/watershot/v0.2.0";
    watershot.inputs.nixpkgs.follows = "nixpkgs";

    # TODO: Wait for random wallpaper support
    # stylix = {
    #   url = "github:danth/stylix";
    #   inputs = {
    #     nixpkgs.follows = "nixpkgs";
    #     home-manager.follows = "home-manager";
    #     flake-compat.follows = "";
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
        diskoConfigurations
        colmenaConfigurations
        (installables "generators")

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
          "steam"
          "steam-run"
          "steam-original"
          "VCV-Rack"
          "osu-lazer-bin"
        ];
    } {
      lib = std.pick self ["repo" "lib"];
      devShells = std.harvest self ["repo" "devshells"];
      packages = let
        generators = std.harvest self ["repo" "generators"];
      in {inherit (generators) x86_64-linux aarch64-linux;};
    } {
      nixosConfigurations = collect self "nixosConfigurations";
      colmenaHive = collect self "colmenaConfigurations";
      # TODO: implement
      # nixosModules = collect self "nixosModules";
      # hmModules = collect self "homeModules";
    };
}
