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
    let
      inherit (fup.lib) mkFlake exportModules;
      pkgs = self.pkgs.x86_64-linux.nixpkgs;
    in fup.lib.mkFlake {
      inherit self inputs;
      supportedSystems = fup.lib.defaultSystems;

      channelsConfig.allowUnfree = true;

      nixosModules = exportModules [ ./hosts/vm ];

      hostDefaults.modules = [ hm.nixosModule ];
      # hostDefaults.modules = with self.nixosModules [ doom xmonad valen time ]; # Optional modules

      hosts = { vm.modules = with self.nixosModules; [ vm ]; };

      outputsBuilder = channels: {
        devShell =
          channels.nixpkgs.mkShell { packages = with pkgs; [ nixfmt ]; };
      };
    };
}
