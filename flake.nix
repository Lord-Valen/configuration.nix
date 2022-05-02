{
  description = "Valen's NixOS Configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    fu.url = "githug:numtide/flake-utils";
    hm = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, fu, hm }:
    fu.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in { devShell = pkgs.mkShell { packages = with pkgs; [ nixfmt ]; }; });
}
