{ inputs, lib, pkgs, ... }:

with lib;
with lib.my; {
  mkHost = path:
    attrs@{ system, ... }:
    nixosSystem {
      inherit system;
      specialArgs = { inherit lib inputs system; };
      modules = [
        {
          nixpkgs.pkgs = pkgs;
          networking.hostName = mkDefault (baseNameOf path);
        }
        (import path)
      ];
    };

  mapHosts = dir:
    attrs@{ system, ... }:
    mapModules dir (path: mkHost path attrs);
}
