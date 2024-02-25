{ inputs, cell }:
let
  inherit (inputs) nixpkgs nix-index-database;
  inherit (nixpkgs) lib;
in
{
  _imports = [ nix-index-database.hmModules.nix-index ];

  bash.enable = true;
  nushell = {
    enable = true;
    configFile.source = ./_config.nu;
    envFile.source = ./_env.nu;
  };

  starship = {
    enable = true;
    settings = {
      character = {
        success_symbol = "[❯](bold purple)";
        vicmd_symbol = "[❮](bold purple)";
      };
      directory.style = "cyan";
      docker_context.symbol = " ";
      git_branch = {
        format = "[$symbol$branch]($style) ";
        style = "bold dimmed white";
      };
      git_status = {
        format = "([「$all_status$ahead_behind」]($style) )";
        conflicted = "⚠";
        ahead = "⟫$count";
        behind = "⟪$count";
        diverged = "🔀";
        stashed = "↪";
        modified = "𝚫";
        staged = "✔";
        renamed = "⇆";
        deleted = "✘";
        style = "bold bright-white";
      };
      haskell.symbol = " ";
      hg_branch.symbol = " ";
      memory_usage = {
        symbol = " ";
        disabled = false;
      };
      nix_shell = {
        format = "[$symbol$state]($style) ";
        pure_msg = "λ";
        impure_msg = "⎔";
      };
      nodejs.symbol = " ";
      package.symbol = " ";
      python.symbol = " ";
      rust.symbol = " ";
      status.disabled = false;
    };
  };

  nix-index-database = {
    comma.enable = true;
  };

  zoxide = {
    enable = true;
    options = lib.cli.toGNUCommandLine { } { cmd = "cd"; };
  };
}
