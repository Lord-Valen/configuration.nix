# DO-NOT-EDIT. This file was auto-generated using github:vic/flake-file.
# Use `nix run .#write-flake` to regenerate it.
{
  description = "Lord-Valen's NixOS Configurations";
  inputs = {
    allfollow = {
      url = "github:spikespaz/allfollow";
    };
    dendrix = {
      url = "github:vic/dendrix";
    };
    devshell = {
      url = "github:numtide/devshell";
    };
    files = {
      url = "github:mightyiam/files";
    };
    flake-file = {
      url = "github:vic/flake-file";
    };
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
    };
    import-tree = {
      url = "github:vic/import-tree";
    };
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-25.05";
    };
    nixpkgs-lib = {
      url = "github:nixos/nixpkgs/nixos-25.05";
    };
    rust-overlay = {
      inputs = {
        nixpkgs = {
          follows = "nixpkgs";
        };
      };
      url = "github:oxalica/rust-overlay";
    };
    stylix = {
      url = "github:danth/stylix/release-25.05";
    };
    systems = {
      url = "github:nix-systems/default";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
    };
  };
  nixConfig = {
    extra-experimental-features = "nix-command flakes pipe-operators";
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://ezkea.cachix.org" # aagl
      "https://colmena.cachix.org" # colmena
      "https://cosmic.cachix.org" # cosmic
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI="
      "colmena.cachix.org-1:7BzpDnjjH8ki2CT3f6GdOk7QAzPOl+1t3LvTLXqYcSg="
      "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
    ];
  };
  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);
}
