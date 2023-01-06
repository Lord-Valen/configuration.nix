{
  pkgs,
  extraModulesPath,
  inputs,
  lib,
  ...
}: let
  inherit
    (pkgs)
    agenix
    editorconfig-checker
    nixUnstable
    treefmt
    alejandra
    shfmt
    nvfetcher-bin
    nixos-generators
    ;
  inherit (pkgs.nodePackages) prettier;

  pkgWithCategory = category: package: {inherit package category;};
  digga = pkgWithCategory "digga";
  format = pkgWithCategory "format";
in {
  imports = ["${extraModulesPath}/git/hooks.nix" ./hooks];

  packages = [
    alejandra
    prettier
    shfmt
    editorconfig-checker
    nixUnstable
  ];

  commands = [
    (digga agenix)
    (digga nixos-generators)
    (digga inputs.deploy.packages.${pkgs.system}.deploy-rs)
    {
      category = "digga";
      name = nvfetcher-bin.pname;
      help = nvfetcher-bin.meta.description;
      command = "nvfetcher -c $PRJ_ROOT/pkgs/sources.toml $@";
    }

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

    (format treefmt)
  ];
}
