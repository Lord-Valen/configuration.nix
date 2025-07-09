{
  inputs,
  config,
  ...
}:
{
  imports = [
    inputs.flake-parts.flakeModules.modules
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
  flake-file.inputs.stylix.url = "github:danth/stylix/release-25.05";
  flake-file.nixConfig = {
    extra-experimental-features = "nix-command flakes pipe-operators";
  };
}
