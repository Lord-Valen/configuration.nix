{ inputs, cell }:
let
  inherit (inputs) nixpkgs;
  inherit (inputs.nixpkgs) lib;

  callPackageWith = attrs: package: lib.callPackageWith (nixpkgs // attrs) package { };
  myUtils = { };

  dirs = lib.filterAttrs (_: type: type == "directory") (builtins.readDir ./.);
  packages = lib.mapAttrs (name: _: ./. + "/${name}/package.nix") dirs;
in
lib.mapAttrs (_: package: callPackageWith { inherit myUtils; } package) packages
