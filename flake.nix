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
    blank.url = "github:divnix/blank";

    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    hardware.url = "github:nixos/nixos-hardware";

    nix-doom-emacs = {
      url = "github:nix-community/nix-doom-emacs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    deploy = {
      url = "github:serokell/deploy-rs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.darwin.follows = "blank";
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
        darwin.follows = "blank";
        nixlib.follows = "nixpkgs";
        home-manager.follows = "home";
        deploy.follows = "deploy";
      };
    };

    # aagl-gtk-on-nix = {
    #   url = "github:ezKEa/aagl-gtk-on-nix/271df5673a4bda398d2bc3ef5d5bb2f6868e2988";
    #   flake = false;
    # };
  };

  outputs = {self, ...} @ inputs: let
    lib = inputs.digga.lib // inputs.nixpkgs.lib // builtins;
  in
    lib.mkFlake {
      inherit self inputs;

      supportedSystems = ["x86_64-linux" "aarch64-linux"];

      channelsConfig = {
        # I want to keep proprietary software to a minimum.
        # allowUnfreePredicate forces me to keep track of what proprietary software I allow.
        allowUnfreePredicate = pkg:
          lib.elem (lib.getName pkg) [
            "discord"
            "hplip"
            "steam"
            "steam-run"
            "steam-original"
          ];
      };

      channels = {
        nixpkgs = {
          imports = [(lib.importOverlays ./overlays)];
          overlays = [];
        };
        nixpkgs-unstable = {};
      };

      lib = import ./lib {inherit lib;};

      sharedOverlays = [
        (final: prev: {
          __dontExport = true;
          lib = prev.lib.extend (lfinal: lprev: {our = self.lib;});
        })

        inputs.agenix.overlays.default
        inputs.nvfetcher.overlays.default

        (import ./pkgs)
      ];

      nixos = {
        hostDefaults = {
          system = "x86_64-linux";
          channelName = "nixpkgs";
          imports = [(lib.importExportableModules ./modules)];
          modules = [
            {lib.our = self.lib;}
            inputs.digga.nixosModules.nixConfig
            inputs.home.nixosModules.home-manager
            inputs.agenix.nixosModules.age
            inputs.arion.nixosModules.arion
            # (import inputs.aagl-gtk-on-nix.module {pkgs = inputs.nixpkgs;})
          ];
        };

        importables = let
          profiles = lib.rakeLeaves ./profiles // {users = lib.rakeLeaves ./users;};
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
          in {
            inherit base chat office develop pc;
            server = base ++ [networking];

            desktop = pc ++ [ipfs];
            laptop = pc ++ [x11.colemak];
          };
        };

        imports = [(lib.importHosts ./hosts)];
        hosts = {
          heracles = {};
          satellite = {};
          theseus = {};
          autolycus.modules = [inputs.hardware.nixosModules.lenovo-thinkpad-t420];
        };
      };

      home = {
        importables = let
          profiles = lib.rakeLeaves ./home/profiles;
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

        imports = [(lib.importExportableModules ./home/modules)];
        modules = [inputs.nix-doom-emacs.hmModule];
        users = {
          nixos = {
            suites,
            profiles,
            ...
          }: {
            home.stateVersion = "22.05";
            imports = suites.base;
          };
          lord-valen = {
            suites,
            profiles,
            ...
          }: {
            home.stateVersion = "22.05";
            imports =
              suites.base
              ++ (
                let
                  inherit (profiles) git doom wallpaper xmobar shell;
                in [doom wallpaper xmobar git.valen shell.nushell]
              );
          };
        };
      };

      devshell = ./shell;

      homeConfigurations = lib.mkHomeConfigurations self.nixosConfigurations;

      deploy.nodes = let
        lib' = lib // inputs.deploy.lib;
      in
        lib'.mkDeployNodes self.nixosConfigurations {
          theseus = {
            profilesOrder = ["system" "nixos"];
            profiles.nixos = {
              user = "lord-valen";
              path = lib'.x86_64-linux.activate.home-manager self.homeConfigurationsPortable.x86_64-linux.lord-valen;
            };
          };
        };
    };
}
