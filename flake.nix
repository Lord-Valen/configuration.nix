{
  description = "Valen's NixOS Configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    fu.url = "github:numtide/flake-utils";
    hm = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, fu, hm }:
    fu.lib.eachDefaultSystem (system:
      let
        inherit (lib.my) mapHosts;
        pkgs = nixpkgs.legacyPackages.${system};
        lib = nixpkgs.lib.extend (self: super: {
          mine = import ./lib {
            inherit pkgs inputs;
            lib = self;
          };
        });
      in {
        lib = lib.mine;

        nixosConfigurations = mapHosts ./hosts/${system};

        devShell = pkgs.mkShell { packages = with pkgs; [ nixfmt ]; };
      });
}
