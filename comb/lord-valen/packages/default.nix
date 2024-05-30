{ inputs, cell }@paisano:
let
  inherit (inputs.nixpkgs) lib;

  inherit (builtins) readDir;
  inherit (lib) callPackageWith filterAttrs mapAttrs;
  inherit (lib.path) append;
  inherit (lib.filesystem) packagesFromDirectoryRecursive;

  callPackage = package: callPackageWith (inputs.nixpkgs // { inherit paisano; });
  dirs = filterAttrs (_: type: type == "directory") (readDir ./.);
in
mapAttrs (
  name: _:
  packagesFromDirectoryRecursive {
    inherit callPackage;
    directory = append ./. name;
  }
) dirs

/*
  NOTE: This would be cleaner but it requires that it is in `../packages.nix`
  rather than `./default.nix`, otherwise `packagesFromDirectoryRecursive` will
  attempt to call this file as a package (`directory = ./.` isn't viable). This
  means that we must check that `./packages` exists, or add a dummy file to
  ensure it exists. This is ugly on top of the architectually confusing state of
  having both `../packages.nix` and `../packages`. Alternatively, we could point
  the function at `./src` but that causes unwarranted nesting.
*/
# { inputs, cell }@paisano:
# let
#   inherit (inputs.nixpkgs) lib;
#   inherit (lib) callPackageWith;
#   inherit (lib.filesystem) packagesFromDirectoryRecursive pathIsDirectory;

#   dir = ./packages;
#   callPackage = package: callPackageWith (inputs.nixpkgs // { inherit paisano; });
# in
# if pathIsDirectory dir then
#   packagesFromDirectoryRecursive {
#     inherit callPackage;
#     directory = ./packages;
#   }
# else
#   { }
