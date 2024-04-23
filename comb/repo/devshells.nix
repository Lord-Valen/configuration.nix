{ inputs, cell }:
let
  inherit (inputs) hive std colmena;
  inherit (cell) pkgs;
  inherit (pkgs) lib;
  inherit (hive.bootstrap.shell) bootstrap;
  inherit (std.lib) dev cfg;
in
{
  default = dev.mkShell {
    name = "Hive";

    imports = [ bootstrap ];
    nixago = with cell.configs; [
      (dev.mkNixago cfg.treefmt treefmt)
      (dev.mkNixago cfg.lefthook lefthook)
      (dev.mkNixago cfg.editorconfig editorconfig)
      (dev.mkNixago cfg.conform conform)
      (dev.mkNixago cfg.lefthook lefthook)
    ];

    packages = with pkgs; [ nixfmt-rfc-style ];

    commands =
      let
        mkCategory = category: attrset: attrset // { inherit category; };
        paisano = mkCategory "paisano";
        bootstrap = mkCategory "bootstrap";
        nix = mkCategory "nix";
      in
      lib.concatLists [
        (with pkgs; [
          { package = nix-inspect; }
          { package = nix-du; }
        ])
        (builtins.map paisano [ { package = std.std.cli.default; } ])
        (builtins.map bootstrap [
          { package = colmena.packages.colmena; }
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
          # TODO: Upstream similar actions to blockTypes
          {
            name = "boot";
            help = "Switch boot configuration";
            command = ''sudo nixos-rebuild boot --flake $PRJ_ROOT "$@"'';
          }
          {
            name = "build";
            help = "Build configuration";
            command = ''nixos-rebuild build --flake $PRJ_ROOT "$@"'';
          }
          {
            name = "check";
            help = "Check flake";
            command = ''nix flake check $PRJ_ROOT "$@"'';
          }
          {
            name = "diff-closures";
            help = "Diff configuration with current-system";
            command = ''
              build "$@"
              nix store diff-closures /run/current-system ./result
            '';
          }
          {
            name = "dry";
            help = "Dry activate configuration";
            command = ''sudo nixos-rebuild dry-activate --flake $PRJ_ROOT "$@"'';
          }
          {
            name = "switch";
            help = "Switch configurations";
            command = ''sudo nixos-rebuild switch --flake $PRJ_ROOT "$@"'';
          }
          {
            name = "test";
            help = "Test configuration";
            command = ''sudo nixos-rebuild test --flake $PRJ_ROOT "$@"'';
          }
          {
            name = "update";
            help = "Update inputs";
            command = ''nix flake update $PRJ_ROOT "$@"'';
          }
        ])
      ];
  };
}
