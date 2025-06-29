{ inputs, cell }:
let
  inherit (inputs) std colmena disko;
  inherit (inputs.hive.bootstrap.shell) bootstrap;
  inherit (inputs.std.lib) dev cfg;
  inherit (cell) pkgs;
  inherit (cell.pkgs) lib;
in
{
  default = dev.mkShell {
    name = "Hive";

    imports = [ bootstrap ];
    nixago = map (name: dev.mkNixago cfg."${name}" cell.configs."${name}") [
      "treefmt"
      "lefthook"
      "editorconfig"
      "lefthook"
    ];

    env = [
      {
        name = "NH_FLAKE";
        eval = "$PRJ_ROOT";
      }
    ];
    packages = with pkgs; [
      nixfmt-rfc-style
      nh
      nvd
      nixos-rebuild
    ];

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
        (map paisano [ { package = std.std.cli.default; } ])
        (map bootstrap [
          {
            name = "colmena";
            help = "A simple, stateless NixOS deployment tool";
            command = ''${lib.getExe colmena.packages.colmena} --experimental-flake-eval "$@"'';
          }
          { package = disko.packages.disko; }
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
        (map nix [
          # TODO: Upstream similar actions to blockTypes
          {
            name = "boot";
            help = "Switch boot configuration";
            command = ''nh os boot "$@"'';
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
            name = "diff";
            help = "Diff configuration with current-system";
            command = ''
              build
              nvd diff "$@" /run/current-system result
              rm result
            '';
          }
          {
            name = "dry";
            help = "Dry activate configuration";
            command = ''nh os switch --dry "$@"'';
          }
          {
            name = "switch";
            help = "Switch configurations";
            command = ''nh os switch "$@"'';
          }
          {
            name = "test";
            help = "Test configuration";
            command = ''nh os test "$@"'';
          }
          {
            name = "update";
            help = "Update inputs";
            command = ''nix flake update --flake $PRJ_ROOT "$@"'';
          }
        ])
      ];
  };
}
