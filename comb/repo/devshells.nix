{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs std colmena;
  inherit (nixpkgs) lib;
  inherit (std.lib) dev cfg;
in
  lib.mapAttrs (_: dev.mkShell) {
    default = {
      name = "Hive";
      nixago = with cell.configs; [
        (dev.mkNixago cfg.treefmt treefmt)
        (dev.mkNixago cfg.lefthook lefthook)
        (dev.mkNixago cfg.editorconfig editorconfig)
        (dev.mkNixago cfg.conform conform)
        (dev.mkNixago cfg.lefthook lefthook)
      ];
      commands = let
        hexagon = attrset: attrset // {category = "hexagon";};
      in [
        (hexagon {package = colmena.packages.colmena;})
        (hexagon {package = nixpkgs.nixos-generators;})

        {
          category = "nix";
          name = "switch";
          help = "Switch configurations";
          command = "sudo nixos-rebuild switch --flake $PRJ_ROOT $@";
        }
        {
          category = "nix";
          name = "boot";
          help = "Switch boot configuration";
          command = "sudo nixos-rebuild boot --flake $PRJ_ROOT $@";
        }
        {
          category = "nix";
          name = "test";
          help = "Test configuration";
          command = "sudo nixos-rebuild test --flake $PRJ_ROOT $@";
        }
        {
          category = "nix";
          name = "update";
          help = "Update inputs";
          command = "nix flake update $PRJ_ROOT $@";
        }
        {
          category = "nix";
          name = "check";
          help = "Check flake";
          command = "nix flake check $PRJ_ROOT $@";
        }
      ];
    };
  }
