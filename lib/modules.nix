{ lib, ... }:

with lib;

{
  getDir = (dir:
    mapAttrs
    (file: type: if type == "directory" then getDir "${dir}/${file}" else type)
    (builtins.readDir dir));

  dirFiles = dir:
    collect isString
    (mapAttrsRecursive (path: type: concatStringsSep "/" path) (getDir dir));

  getModules = dir:
    map (file: dir + "/${file}") (filter (file:
      ((hasSuffix ".nix" file) && (!(hasSuffix ".lib.nix" file))
        && (file != "default.nix") && (file != "shell.nix"))) (dirFiles dir));

  mapModules = dir: fn: map (fn) (getModules);

  recImport = dir: mapModules dir import;
}
