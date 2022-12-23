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
    ;
  inherit (pkgs.nodePackages) prettier;

  pkgWithCategory = category: package: {inherit package category;};
  digga = pkgWithCategory "digga";
  nix = pkgWithCategory "nix";
  format = pkgWithCategory "format";
in {
  imports = ["${extraModulesPath}/git/hooks.nix" ./hooks];

  packages = [
    alejandra
    prettier
    shfmt
    editorconfig-checker
  ];

  commands = [
    (digga agenix)
    (digga inputs.nixos-generators.defaultPackage.${pkgs.system})
    (digga inputs.deploy.packages.${pkgs.system}.deploy-rs)
    {
      category = "digga";
      name = nvfetcher-bin.pname;
      help = nvfetcher-bin.meta.description;
      command = "cd $PRJ_ROOT/pkgs; ${nvfetcher-bin}/bin/nvfetcher -c ./sources.toml $@";
    }

    (nix nixUnstable)
    {
      category = "nix";
      name = "switch";
      help = "Switch configurations";
      command = "sudo nixos-rebuild switch --flake $PRJ_ROOT";
    }
    {
      category = "nix";
      name = "boot";
      help = "Switch boot configuration";
      command = "sudo nixos-rebuild boot --flake $PRJ_ROOT";
    }

    (format treefmt)
  ];
}
