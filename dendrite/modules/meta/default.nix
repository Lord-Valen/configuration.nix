{
  inputs,
  config,
  ...
}:
{
  imports = [
    inputs.flake-parts.flakeModules.modules
    inputs.flake-file.flakeModules.default
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

  flake-file.inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
  flake-file.inputs.nixpkgs-lib =
    if config.flake-file.inputs ? nixpkgs then
      { follows = "nixpkgs"; }
    else
      { url = "github:nix-community/nixpkgs.lib"; };
  flake-file.nixConfig = {
    extra-experimental-features = "nix-command flakes pipe-operators";
  };
}
