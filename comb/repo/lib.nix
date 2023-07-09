{
  inputs,
  cell,
}: let
  inherit (inputs) std hive;
  inherit (hive.inputs) haumea;
  lib = inputs.nixpkgs.lib // builtins;
  getImports = attrs:
    if attrs ? imports
    then attrs.imports
    else [];
in
  rec {
    inherit std hive haumea;

    rakeLeaves = dirPath: let
      seive = file: type:
      # Only rake `.nix` files or directories
        (type == "regular" && lib.hasSuffix ".nix" file)
        || (type == "directory");

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
      lib.filterAttrs (name: value: value != {})
      (lib.mapAttrs' collect files);

    mkNixosConfigurations' = cell: common: configurations:
      lib.mapAttrs
      (host: config: lib.recursiveUpdate config (common {inherit host config;}))
      configurations;

    mkNixosConfigurations = cell: configurations:
      mkNixosConfigurations' cell ({
        host,
        config,
      }: {
        imports =
          [
            cell.hardwareProfiles.${host}
            {networking.hostName = lib.mkDefault "${host}";}
          ]
          ++ getImports config;
      })
      configurations;

    mkColmenaConfigurations' = cell: common: configurations:
      lib.mapAttrs
      (host: config: lib.recursiveUpdate config (common {inherit host config;}))
      configurations;

    mkColmenaConfigurations = cell: defaults: configurations:
      mkColmenaConfigurations' cell ({
        host,
        config,
      }: {
        imports =
          [cell.nixosConfigurations.${host}]
          ++ getImports config
          ++ getImports defaults;
      }) (lib.mapAttrs (_: value: lib.recursiveUpdate defaults value) configurations);

    load = inputs: cell: src: inputs.hive.load {inherit inputs cell src;};
    loadAll = load: path: lib.mapAttrs (name: _: load "${path}/${name}") (lib.readDir path);
  }
  // lib
