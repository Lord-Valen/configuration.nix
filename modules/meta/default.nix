{
  inputs,
  config,
  ...
}:
{
  imports = [
    (inputs.flake-parts.flakeModules.modules or { })
    (inputs.flake-file.flakeModules.default or { })
    (inputs.flake-file.flakeModules.nix-auto-follow or { })
    (inputs.flake-aspects.flakeModule or { })
  ];

  flake-file.description = "Lord-Valen's NixOS Configurations";
  flake-file.inputs.flake-parts.url = "github:hercules-ci/flake-parts";
  flake-file.inputs.flake-aspects.url = "github:vic/flake-aspects/v0.2.0";
  flake-file.inputs.import-tree.url = "github:vic/import-tree/v0.1.0";
  flake-file.inputs.flake-file.url = "github:vic/flake-file/0.1.0";
  flake-file.inputs.systems.url = "github:nix-systems/default";

  flake-file.outputs = ''
    inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules)
  '';

  systems = import inputs.systems;

  flake-file.inputs.nixpkgs.url = "https://channels.nixos.org/nixos-25.11/nixexprs.tar.xz";
  flake-file.inputs.nixpkgs-lib.follows = "nixpkgs";
  flake-file.nixConfig = {
    extra-experimental-features = "nix-command flakes pipe-operators";
  };
}
