{
  inputs,
  config,
  ...
}:
{
  imports = [
    inputs.flake-file.flakeModules.default
    inputs.files.flakeModules.default
  ];
  flake-file.description = "Lord-Valen's NixOS Configurations";
  flake-file.inputs.flake-parts.url = "github:hercules-ci/flake-parts";
  flake-file.inputs.import-tree.url = "github:vic/import-tree";
  flake-file.inputs.flake-file.url = "github:vic/flake-file";
  flake-file.inputs.allfollow.url = "github:spikespaz/allfollow";
  flake-file.inputs.systems.url = "github:nix-systems/default";
  flake-file.outputs = ''
    inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules)
  '';
  systems = import inputs.systems;

  flake-file.inputs.files.url = "github:mightyiam/files";

  flake-file.inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
  flake-file.inputs.nixpkgs-lib.url =
    if config.flake-file.inputs ? nixpkgs then
      config.flake-file.inputs.nixpkgs.url
    else
      "github:nix-community/nixpkgs.lib";
  flake-file.inputs.home-manager.url = "github:nix-community/home-manager/release-25.05";
  flake-file.inputs.stylix.url = "github:danth/stylix/release-25.05";
  flake-file.nixConfig = {
    extra-experimental-features = "nix-command flakes pipe-operators";

    extra-substituters = [
      # nix-community
      "https://nix-community.cachix.org"
      # aagl
      "https://ezkea.cachix.org"
      # colmena
      "https://colmena.cachix.org"
    ];

    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI="
      "colmena.cachix.org-1:7BzpDnjjH8ki2CT3f6GdOk7QAzPOl+1t3LvTLXqYcSg="
      "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
    ];
  };
}
