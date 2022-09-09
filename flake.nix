{
  description = "Lord-Valen's NixOS Configurations";

  nixConfig.extra-experimental-features = "nix-command flakes";
  nixConfig.extra-substituters =
    [ "https://nix-community.cachix.org" "https://nrdxp.cachix.org" ];
  nixConfig.extra-trusted-public-keys = [
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    "nrdxp.cachix.org-1:Fc5PSqY2Jm1TrWfm88l6cvGWwz3s93c6IOifQWnhNW4="
  ];

  inputs = {
    stable.url = "github:nixos/nixpkgs/nixos-22.05";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.follows = "stable";
    nur.url = "github:nix-community/NUR";

    hardware.url = "github:nixos/nixos-hardware";

    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs = {
        nixpkgs.follows = "stable";
        nixlib.follows = "stable";
      };
    };

    nix-doom-emacs = {
      url = "github:nix-community/nix-doom-emacs";
      inputs.nixpkgs.follows = "stable";
    };

    home = {
      url = "github:nix-community/home-manager/release-22.05";
      inputs.nixpkgs.follows = "stable";
    };

    deploy = {
      url = "github:serokell/deploy-rs";
      inputs.nixpkgs.follows = "stable";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "stable";
    };

    nvfetcher = {
      url = "github:berberman/nvfetcher";
      inputs.nixpkgs.follows = "stable";
    };

    arion = {
      url = "github:hercules-ci/arion";
      inputs.nixpkgs.follows = "stable";
    };

    digga = {
      url = "github:divnix/digga";
      inputs = {
        nixpkgs.follows = "stable";
        nixpkgs-unstable.follows = "unstable";
        nixlib.follows = "stable";
        home-manager.follows = "home";
        deploy.follows = "deploy";
      };
    };
  };

  outputs =
    { self
    , nixpkgs
    , stable
    , unstable
    , nur
    , hardware
    , nix-doom-emacs
    , home
    , deploy
    , agenix
    , nvfetcher
    , arion
    , digga
    , ...
    }@inputs:
    digga.lib.mkFlake {
      inherit self inputs;

      supportedSystems = [ "x86_64-linux" ];

      channelsConfig = { allowUnfree = true; };

      channels = {
        stable = {
          imports = [ (digga.lib.importOverlays ./overlays) ];
          overlays = [ ];
        };
        unstable = { };
      };

      lib = import ./lib { lib = digga.lib // stable.lib; };

      sharedOverlays = [
        (final: prev: {
          __dontExport = true;
          lib = prev.lib.extend (lfinal: lprev: { our = self.lib; });
        })

        nur.overlay
        agenix.overlay
        nvfetcher.overlay

        (import ./pkgs)
      ];

      nixos = {
        hostDefaults = {
          system = "x86_64-linux";
          channelName = "stable";
          imports = [ (digga.lib.importExportableModules ./modules) ];
          modules = [
            { lib.our = self.lib; }
            digga.nixosModules.bootstrapIso
            digga.nixosModules.nixConfig
            home.nixosModules.home-manager
            agenix.nixosModules.age
            arion.nixosModules.arion
          ];
        };

        importables = rec {
          profiles = digga.lib.rakeLeaves ./profiles // {
            users = digga.lib.rakeLeaves ./users;
          };
          suites = with profiles; rec {
            base = [ core.nixos fonts users.nixos users.root gpg pkgscfg ];

            pc = base ++ [ audio.common networking x11.xmonad printing users.lord-valen discord ];
            server = base ++ [ networking ];

            desktop = pc ++ [ ipfs audio.jack ];
            laptop = pc ++ [ ];
          };
        };

        imports = [ (digga.lib.importHosts ./hosts) ];
        hosts = {
          heracles = { };
          satellite = { };
        };
      };

      home = {
        importables = rec {
          profiles = digga.lib.rakeLeaves ./users/profiles;
          suites = with profiles; rec { base = [ direnv git xdg ]; };
        };

        imports = [ (digga.lib.importExportableModules ./users/modules) ];
        modules = [ nix-doom-emacs.hmModule ];
        users = {
          nixos = { suites, profiles, ... }: { imports = suites.base; };
          lord-valen = { suites, profiles, ... }: {
            imports = suites.base ++ (with profiles; [ doom wallpaper xmobar ]);
          };
        };
      };

      devshell = ./shell;

      homeConfigurations =
        digga.lib.mkHomeConfigurations self.nixosConfigurations;

      deploy.nodes = digga.lib.mkDeployNodes self.nixosConfigurations { };
    };
}
