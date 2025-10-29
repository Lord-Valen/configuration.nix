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
      typescript-language-server
      vscode-langservers-extracted
      yaml-language-server
      bash-language-server
      nixd
      taplo
      rust-analyzer
      haskell-language-server
      clang-tools
      marksman
      typstyle
      tinymist
    ];
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
      ];
  };
}
