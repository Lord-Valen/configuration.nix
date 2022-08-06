{
  description = "Valen's NixOS Configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    fup.url = "github:gytis-ivaskevicius/flake-utils-plus";
    hm = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, fup, hm }@inputs:
    with builtins;
    with nixpkgs.lib;
    let
      inherit (fup.lib) mkFlake exportModules;
      pkgs = self.pkgs.x86_64-linux.nixpkgs;
    in fup.lib.mkFlake {
      inherit self inputs;
      supportedSystems = [ "x86_64-linux" ];

      channelsConfig.allowUnfree = true;

      nixosModules = exportModules [
        ./hosts

        ./modules/home
        ./modules/xdg
        ./modules/fonts

        ./modules/user
        ./modules/emacs
        ./modules/pipewire
        ./modules/x11
        ./modules/networking
        ./modules/tidal
        ./modules/monero
        ./modules/vm
        ./modules/docker
        ./modules/ipfs
        ./modules/games
        ./modules/dev
        ./modules/syncthing.nix
      ];

      hostDefaults.modules = with self.nixosModules; [
        hm.nixosModules.home-manager

        hosts
        home
        xdg
        fonts

        user
        emacs
        pipewire
        x11
        networking
        tidal
        monero
        vm
        docker
        ipfs
        games
        dev
        syncthing
      ];

      hosts = {
        box.modules = [ ./hosts/box ];
        satellite.modules = [ ./hosts/satellite ];
        heracles.modules = [ ./hosts/heracles ];
      };

      outputsBuilder = channels: {
        devShells.default =
          channels.nixpkgs.mkShell { packages = with pkgs; [ nixfmt ]; };
      };
    };
}
