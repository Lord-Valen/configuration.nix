# DO-NOT-EDIT. This file was auto-generated using github:vic/flake-file.
# Use `nix run .#write-flake` to regenerate it.
{
  description = "Lord-Valen's NixOS Configurations";

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);

  nixConfig = {
    extra-experimental-features = "nix-command flakes pipe-operators";
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
    extra-trusted-substituters = [ "https://nix-community.cachix.org" ];
  };

  inputs = {
    den.url = "github:denful/den";
    devshell.url = "github:numtide/devshell";
    disko.url = "github:nix-community/disko/v1.13.0";
    elcoco.url = "github:Lord-Valen/elcoco";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    files = {
      url = "github:mightyiam/files";
      flake = false;
    };
    flake-file.url = "github:denful/flake-file/v0.6.0";
    flake-parts.url = "github:hercules-ci/flake-parts";
    home-manager.url = "github:nix-community/home-manager/release-26.05";
    import-tree.url = "github:denful/import-tree/v0.2.0";
    musnix.url = "github:musnix/musnix";
    nix-auto-follow = {
      url = "github:fzakaria/nix-auto-follow";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database.url = "github:nix-community/nix-index-database";
    nixos-facter-modules.url = "github:nix-community/nixos-facter-modules";
    nixpkgs.url = "https://channels.nixos.org/nixos-26.05/nixexprs.tar.xz";
    nixpkgs-lib.follows = "nixpkgs";
    nixpkgs-registry.url = "github:Lord-Valen/nixpkgs-registry";
    pkgs-by-name.url = "github:drupol/pkgs-by-name-for-flake-parts";
    sops-nix.url = "github:Mic92/sops-nix";
    stylix.url = "github:nix-community/stylix/release-26.05";
    systems.url = "github:nix-systems/default";
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };
}
