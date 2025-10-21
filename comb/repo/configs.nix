{ inputs, cell }:
let
  inherit (cell) pkgs;
  inherit (pkgs) lib;
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

      "*.{diff,patch,lock}" = {
        charset = "unset";
        end_of_line = "unset";
        insert_final_newline = "unset";
        trim_trailing_whitespace = "unset";
        indent_style = "unset";
        indent_size = "unset";
      };

      "*.md" = {
        max_line_length = "off";
        trim_trailing_whitespace = false;
      };

      "{LICENCES/**,LICENCE}" = {
        end_of_line = "unset";
        insert_final_newline = "unset";
        trim_trailing_whitespace = "unset";
        charset = "unset";
        indent_style = "unset";
        indent_size = "unset";
      };
    };
  };

  treefmt = {
    packages = with pkgs; [
      nixfmt-rfc-style
      nodePackages.prettier
      shfmt
    ];
    data = {
      formatter = {
        nix = {
          command = "${lib.getExe pkgs.nixfmt-rfc-style}";
          options = lib.cli.toGNUCommandLine { } { verify = true; };
          includes = [ "*.nix" ];
        };
        prettier = {
          command = "${lib.getExe pkgs.nodePackages.prettier}";
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
          command = "${lib.getExe pkgs.shfmt}";
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
      pre-commit.commands = {
        treefmt = {
          run = "${lib.getExe pkgs.treefmt} --fail-on-change {staged_files}";
          skip = [
            "merge"
            "rebase"
          ];
        };
      };
    };
  };
}
