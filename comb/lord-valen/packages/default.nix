{ inputs, cell }:
let
  inherit (inputs) nixpkgs;
  inherit (nixpkgs) lib;

  dirs = lib.filterAttrs (_: type: type == "directory") (builtins.readDir ./.);
  packages = lib.mapAttrs (name: _: ./. + "/${name}/package.nix") dirs;
in
lib.mapAttrs (_: package: lib.callPackageWith nixpkgs package { }) packages
