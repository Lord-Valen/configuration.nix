{
  inputs,
  cell,
  lib,
  pkgs,
}:
{
  programs.helix = {
    enable = true;
    extraPackages = with pkgs; [
      nodePackages.typescript-language-server
      nodePackages.vscode-langservers-extracted
      nodePackages.yaml-language-server
      nodePackages.bash-language-server
      nixd
      taplo
      rust-analyzer
      haskell-language-server
      clang-tools
      marksman
    ];
    languages.language-server = {
      nixd = {
        command = lib.getExe pkgs.nixd;
      };
    };
    languages.language =
      let
        prettier = {
          command = lib.getExe pkgs.nodePackages.prettier;
          args = lib.cli.toGNUCommandLine { } { w = true; };
        };
        jsRoots = [
          "package.json"
          "package-lock.json"
          "yarn.lock"
          "deno.json"
          "deno.lock"
          "bun.lockb"
        ];
      in
      [
        {
          name = "javascript";
          roots = jsRoots;
          formatter = prettier;
          auto-format = true;
        }
        {
          name = "typescript";
          roots = jsRoots;
          formatter = prettier;
          auto-format = true;
        }
        {
          name = "markdown";
          formatter = prettier;
          auto-format = true;
        }
        {
          name = "nix";
          roots = [
            "flake.nix"
            "flake.lock"
          ];
          auto-format = true;
          language-servers = [ "nixd" ];
        }
      ];
  };
}
