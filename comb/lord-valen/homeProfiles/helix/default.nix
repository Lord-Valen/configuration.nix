{
  programs.helix = {
    enable = true;
    langauages =
      let
        prettier = {
          command = "prettier";
          args = "-w";
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
        }
        {
          name = "typescript";
          roots = jsRoots;
          formatter = prettier;
        }
        {
          name = "markdown";
          formatter = prettier;
        }
        {
          name = "nix";
          roots = [
            "flake.nix"
            "flake.lock"
          ];
        }
      ];
  };
}
