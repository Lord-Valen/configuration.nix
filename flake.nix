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

    std.url = "github:divnix/std";
    std-data-collection.url = "github:divnix/std-data-collection";

    hive = {
      url = "github:divnix/hive";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
        disko.follows = "disko";
      };
    };

    hardware.url = "github:nixos/nixos-hardware";

    nix-doom-emacs = {
      url = "github:nix-community/nix-doom-emacs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.darwin.follows = "blank";
    };

    arion = {
      url = "github:hercules-ci/arion";
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
    lib = inputs.nixpkgs.lib // builtins;
  in
    hive.growOn {
      inherit inputs;

      cellsFrom = ./comb;
      cellBlocks = with std.blockTypes;
      with hive.blockTypes; [
        # modules
        (functions "nixosModules")
        (functions "homeModules")

        # profiles
        (functions "nixosProfiles")
        (functions "homeProfiles")

        # suites
        (functions "nixosSuites")
        (functions "homeSuites")

        # configurations
        nixosConfigurations
        homeConfigurations

        # devshells
        (devshells "devshells")
        (nixago "configs")
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
      devShells = std.harvest self ["_queen" "devshells"];
    }
    {
      nixosConfigurations = hive.collect self "nixosConfigurations";
      homeConfigurations = hive.collect self "homeConfigurations";
    };
}
# channels = {
#   nixpkgs = {
#     imports = [(lib.importOverlays ./overlays)];
#     overlays = [];
#   };
#   nixpkgs-unstable = {};
# };
#   sharedOverlays = [
#     (final: prev: {
#       __dontExport = true;
#       lib = prev.lib.extend (lfinal: lprev: {our = self.lib;});
#     })
#     inputs.agenix.overlays.default
#     inputs.nvfetcher.overlays.default
#     (import ./pkgs)
#   ];
#   nixos = {
#     hostDefaults = {
#       system = "x86_64-linux";
#       channelName = "nixpkgs";
#       imports = [(lib.importExportableModules ./modules)];
#       modules = [
#         {lib.our = self.lib;}
#         inputs.digga.nixosModules.nixConfig
#         inputs.home.nixosModules.home-manager
#         inputs.agenix.nixosModules.age
#         inputs.arion.nixosModules.arion
#         # (import inputs.aagl-gtk-on-nix.module {pkgs = inputs.nixpkgs;})
#       ];
#     };
#     importables = let
#       profiles = lib.rakeLeaves ./profiles // {users = lib.rakeLeaves ./users;};
#     in {
#       profiles = profiles;
#       suites = let
#         inherit
#           (profiles)
#           core
#           users
#           dev
#           audio
#           x11
#           networking
#           fonts
#           gpg
#           printing
#           discord
#           ipfs
#           telegram
#           matrix
#           latex
#           onlyoffice
#           zotero
#           browser
#           yubikey
#           ;
#         base = [core fonts users.root gpg];
#         chat = [discord telegram matrix];
#         office = [zotero latex onlyoffice printing];
#         develop = [dev.npm];
#         pc =
#           base
#           ++ chat
#           ++ office
#           ++ develop
#           ++ [audio.common networking yubikey x11.xmonad browser users.lord-valen];
#       in {
#         inherit base chat office develop pc;
#         server = base ++ [networking];
#         desktop = pc ++ [ipfs];
#         laptop = pc ++ [x11.colemak];
#       };
#     };
#     imports = [(lib.importHosts ./hosts)];
#     hosts = {
#       heracles = {};
#       satellite = {};
#       theseus = {};
#       autolycus.modules = [inputs.hardware.nixosModules.lenovo-thinkpad-t420];
#     };
#   };
#   home = {
#     importables = let
#       profiles = lib.rakeLeaves ./home/profiles;
#     in {
#       profiles = profiles;
#       suites = let
#         inherit
#           (profiles)
#           direnv
#           git
#           xdg
#           ;
#       in {base = [direnv git.common xdg];};
#     };
#     imports = [(lib.importExportableModules ./home/modules)];
#     modules = [inputs.nix-doom-emacs.hmModule];
#     users = {
#       nixos = {
#         suites,
#         profiles,
#         ...
#       }: {
#         home.stateVersion = "22.05";
#         imports = suites.base;
#       };
#       lord-valen = {
#         suites,
#         profiles,
#         ...
#       }: {
#         home.stateVersion = "22.05";
#         imports =
#           suites.base
#           ++ (
#             let
#               inherit (profiles) git doom wallpaper xmobar shell;
#             in [doom wallpaper xmobar git.valen shell.nushell]
#           );
#       };
#     };
#   };
# };

