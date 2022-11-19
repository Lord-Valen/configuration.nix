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
    cachix
    editorconfig-checker
    mdbook
    nixUnstable
    treefmt
    alejandra
    shfmt
    nvfetcher-bin
    ;
  inherit (pkgs.nodePackages) prettier;

  hooks = import ./hooks;

  pkgWithCategory = category: package: {inherit package category;};
  devos = pkgWithCategory "devos";
  formatter = pkgWithCategory "formatter";
  linter = pkgWithCategory "linter";
  docs = pkgWithCategory "docs";
in {
  _file = toString ./.;

  imports = ["${extraModulesPath}/git/hooks.nix"];
  git = {inherit hooks;};

  commands =
    [
      (devos nixUnstable)
      (devos agenix)
      {
        category = "devos";
        name = nvfetcher-bin.pname;
        help = nvfetcher-bin.meta.description;
        command = "cd $PRJ_ROOT/pkgs; ${nvfetcher-bin}/bin/nvfetcher -c ./sources.toml $@";
      }

      (formatter treefmt)
      (formatter alejandra)
      (formatter shfmt)
      (formatter prettier)

      (linter editorconfig-checker)

      (docs mdbook)
    ]
    ++ lib.optionals (!pkgs.stdenv.buildPlatform.isi686) [
      (devos cachix)
    ]
    ++ lib.optionals (pkgs.stdenv.hostPlatform.isLinux && !pkgs.stdenv.buildPlatform.isDarwin) [
      (devos inputs.nixos-generators.defaultPackage.${pkgs.system})
      (devos inputs.deploy.packages.${pkgs.system}.deploy-rs)
    ];
}
