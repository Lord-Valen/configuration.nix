{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs hive std colmena;
  inherit (nixpkgs) lib;
  inherit (hive.bootstrap.shell) bootstrap;
  inherit (std.lib) dev cfg;
in
  lib.mapAttrs (_: dev.mkShell) {
    default = {
      name = "Hive";

      imports = [bootstrap];
      nixago = with cell.configs; [
        (dev.mkNixago cfg.treefmt treefmt)
        (dev.mkNixago cfg.lefthook lefthook)
        (dev.mkNixago cfg.editorconfig editorconfig)
        (dev.mkNixago cfg.conform conform)
        (dev.mkNixago cfg.lefthook lefthook)
      ];

      commands = let
        mkCategory = category: attrset: attrset // {inherit category;};
        hexagon = mkCategory "hexagon";
        nix = mkCategory "nix";
      in
        lib.concatLists [
          (builtins.map hexagon [
            {package = colmena.packages.colmena;}
            {
              name = "larva";
              help = "Write a minimal iso to disk";
              command = ''
                writedisk $(nixos-generate --flake "$PRJ_ROOT"#larva -f install-iso)
              '';
            }
            {
              name = "demo";
              help = "Write a GNOME iso to disk";
              command = ''
                writedisk $(nixos-generate --flake "$PRJ_ROOT"#demo -f install-iso)
              '';
            }
          ])
          (builtins.map nix [
            {
              name = "switch";
              help = "Switch configurations";
              command = "sudo nixos-rebuild switch --flake $PRJ_ROOT $@";
            }
            {
              name = "boot";
              help = "Switch boot configuration";
              command = "sudo nixos-rebuild boot --flake $PRJ_ROOT $@";
            }
            {
              name = "test";
              help = "Test configuration";
              command = "sudo nixos-rebuild test --flake $PRJ_ROOT $@";
            }
            {
              name = "update";
              help = "Update inputs";
              command = "nix flake update $PRJ_ROOT $@";
            }
            {
              name = "check";
              help = "Check flake";
              command = "nix flake check $PRJ_ROOT $@";
            }
          ])
        ];
    };
  }
