{
  inputs,
  cell,
}: let
  inherit (inputs) std hive;
  lib = inputs.nixpkgs.lib // builtins;
  getImports = attrs:
    if attrs ? imports
    then attrs.imports
    else [];
in
  rec {
    inherit std hive;

    rakeLeaves = dirPath: let
      seive = file: type:
      # Only rake `.nix` files or directories
        (type == "regular" && lib.hasSuffix ".nix" file) || (type == "directory");

      collect = file: type: {
        name = lib.removeSuffix ".nix" file;
        value = let
          path = dirPath + "/${file}";
        in
          if
            (type == "regular")
            || (type == "directory" && lib.pathExists (path + "/default.nix"))
          then path
          # recurse on directories that don't contain a `default.nix`
          else rakeLeaves path;
      };

      files = lib.filterAttrs seive (lib.readDir dirPath);
    in
      lib.filterAttrs (name: value: value != {}) (lib.mapAttrs' collect files);

    mkNixosConfigurations = cell: configurations:
      lib.mapAttrs (
        name: value:
          lib.recursiveUpdate
          value
          {
            imports = [cell.hardwareProfiles.${name}] ++ getImports value;
            networking.hostName = "${name}";
          }
      )
      configurations;

    mkColmenaConfigurations = cell: defaults: configurations:
      lib.mapAttrs (
        name: value:
          lib.recursiveUpdate
          defaults
          value
          // {
            imports = [cell.nixosConfigurations.${name}] ++ getImports value ++ getImports defaults;
          }
      )
      configurations;

    load = inputs: cell: src:
      inputs.hive.load {
        inherit inputs cell src;
      };
  }
  // lib
