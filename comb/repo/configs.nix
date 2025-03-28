{ inputs, cell }:
let
  nixpkgs = cell.pkgs;
  inherit (nixpkgs) lib;
in
{
  editorconfig = {
    hook.mode = "copy";
    data = {
      root = true;

      "*" = {
        end_of_line = "lf";
        insert_final_newline = true;
        trim_trailing_whitespace = true;
        charset = "utf-8";
        indent_style = "space";
        indent_size = 2;
      };

      "*.{diff,patch}" = {
        end_of_line = "unset";
        insert_final_newline = "unset";
        trim_trailing_whitespace = "unset";
        indent_size = "unset";
      };

      "*.md" = {
        max_line_length = "off";
        trim_trailing_whitespace = false;
      };

      "{LICENSES/**,LICENSE}" = {
        end_of_line = "unset";
        insert_final_newline = "unset";
        trim_trailing_whitespace = "unset";
        charset = "unset";
        indent_style = "unset";
        indent_size = "unset";
      };
    };
  };

  conform = {
    hook.mode = "copy";
    data = {
      inherit (inputs) cells;
      commit = {
        header.length = 89;
        conventional = {
          types = [
            "chore"
            "dev"
            "ci"
            "docs"
            "feat"
            "fix"
            "refactor"
            "style"
            "test"
          ];
          scopes = [ ];
        };
      };
    };
  };

  treefmt = {
    packages = with nixpkgs; [
      nixfmt-rfc-style
      nodePackages.prettier
      shfmt
    ];
    data = {
      formatter = {
        nix = {
          command = "${lib.getExe nixpkgs.nixfmt-rfc-style}";
          options = lib.cli.toGNUCommandLine { } { verify = true; };
          includes = [ "*.nix" ];
        };
        prettier = {
          command = "${lib.getExe nixpkgs.nodePackages.prettier}";
          options = lib.cli.toGNUCommandLine { } { write = true; };
          includes = [
            "*.css"
            "*.html"
            "*.js"
            "*.json"
            "*.jsx"
            "*.md"
            "*.mdx"
            "*.scss"
            "*.ts"
            "*.yaml"
          ];
        };
        shell = {
          command = "${lib.getExe nixpkgs.shfmt}";
          options = lib.cli.toGNUCommandLine { } {
            indent = 2;
            simplify = true;
            write = true;
          };
          includes = [ "*.sh" ];
        };
      };
    };
  };

  lefthook = {
    data = {
      commit-msg = {
        commands = {
          conform = {
            # allow WIP, fixup!/squash! commits locally
            run = ''
              [[ "$(head -n 1 {1})" =~ ^WIP(:.*)?$|^wip(:.*)?$|fixup\!.*|squash\!.* ]] ||
              ${lib.getExe nixpkgs.conform} enforce --commit-msg-file {1}'';
            skip = [
              "merge"
              "rebase"
            ];
          };
        };
      };
      pre-commit = {
        commands = {
          treefmt = {
            run = "${lib.getExe nixpkgs.treefmt} --fail-on-change {staged_files}";
            skip = [
              "merge"
              "rebase"
            ];
          };
        };
      };
    };
  };
}
