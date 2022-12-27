{
  description = "Lord-Valen's NixOS Configurations";

  nixConfig.extra-experimental-features = "nix-command flakes";
  nixConfig.extra-substituters = [
    "https://nix-community.cachix.org"
    "https://nrdxp.cachix.org"
  ];
  nixConfig.extra-trusted-public-keys = [
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    "nrdxp.cachix.org-1:Fc5PSqY2Jm1TrWfm88l6cvGWwz3s93c6IOifQWnhNW4="
  ];

  inputs = {
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };

    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    hardware.url = "github:nixos/nixos-hardware";

    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        nixlib.follows = "nixpkgs";
      };
    };

    nix-doom-emacs = {
      url = "github:nix-community/nix-doom-emacs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home = {
      url = "github:nix-community/home-manager/release-22.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    deploy = {
      url = "github:serokell/deploy-rs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvfetcher = {
      url = "github:berberman/nvfetcher";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    arion = {
      url = "github:hercules-ci/arion";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    digga = {
      url = "github:divnix/digga";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        nixpkgs-unstable.follows = "nixpkgs-unstable";
        nixlib.follows = "nixpkgs";
        home-manager.follows = "home";
        deploy.follows = "deploy";
      };
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    hardware,
    nix-doom-emacs,
    home,
    deploy,
    agenix,
    nvfetcher,
    arion,
    digga,
    ...
  } @ inputs:
    digga.lib.mkFlake {
      inherit self inputs;

      supportedSystems = ["x86_64-linux"];

      channelsConfig = {
        # I want to keep proprietary software to a minimum.
        # allowUnfreePredicate forces me to keep track of what proprietary software I allow.
        allowUnfreePredicate = pkg:
          builtins.elem (nixpkgs.lib.getName pkg) [
            "discord"
            "hplip"
            "steam"
            "steam-run"
            "steam-original"
          ];
      };

      channels = {
        nixpkgs = {
          imports = [(digga.lib.importOverlays ./overlays)];
          overlays = [];
        };
        nixpkgs-unstable = {};
      };

      lib = import ./lib {lib = digga.lib // nixpkgs.lib;};

      sharedOverlays = [
        (final: prev: {
          __dontExport = true;
          lib = prev.lib.extend (lfinal: lprev: {our = self.lib;});
        })

        agenix.overlay
        nvfetcher.overlay

        (import ./pkgs)
      ];

      nixos = {
        hostDefaults = {
          system = "x86_64-linux";
          channelName = "nixpkgs";
          imports = [(digga.lib.importExportableModules ./modules)];
          modules = [
            {lib.our = self.lib;}
            digga.nixosModules.bootstrapIso
            digga.nixosModules.nixConfig
            home.nixosModules.home-manager
            agenix.nixosModules.age
            arion.nixosModules.arion
          ];
        };

        importables = let
          profiles = digga.lib.rakeLeaves ./profiles // {users = digga.lib.rakeLeaves ./users;};
        in {
          profiles = profiles;
          suites = let
            inherit
              (profiles)
              core
              users
              dev
              audio
              x11
              networking
              fonts
              gpg
              printing
              discord
              ipfs
              telegram
              matrix
              latex
              onlyoffice
              zotero
              browser
              yubikey
              ;
          in rec {
            base = [core fonts users.root gpg];
            chat = [discord telegram matrix];
            office = [zotero latex onlyoffice printing];
            develop = [dev.npm];

            pc =
              base
              ++ chat
              ++ office
              ++ develop
              ++ [audio.common networking yubikey x11.xmonad browser users.lord-valen];
            server = base ++ [networking];

            desktop = pc ++ [ipfs audio.jack];
            laptop = pc ++ [x11.colemak];
          };
        };

        imports = [(digga.lib.importHosts ./hosts)];
        hosts = {
          heracles = {};
          satellite = {};
          autolycus.modules = [hardware.nixosModules.lenovo-thinkpad-t430];
        };
      };

      home = {
        importables = let
          profiles = digga.lib.rakeLeaves ./users/profiles;
        in {
          profiles = profiles;
          suites = let
            inherit
              (profiles)
              direnv
              git
              xdg
              ;
          in {base = [direnv git.common xdg];};
        };

        imports = [(digga.lib.importExportableModules ./users/modules)];
        modules = [nix-doom-emacs.hmModule];
        users = {
          nixos = {
            suites,
            profiles,
            ...
          }: {imports = suites.base;};
          lord-valen = {
            suites,
            profiles,
            ...
          }: {
            imports =
              suites.base
              ++ (
                let
                  inherit (profiles) git doom wallpaper xmobar;
                in [doom wallpaper xmobar git.valen]
              );
          };
        };
      };

      devshell = ./shell;

      homeConfigurations =
        digga.lib.mkHomeConfigurations self.nixosConfigurations;

      deploy.nodes = digga.lib.mkDeployNodes self.nixosConfigurations {};
    };
}
