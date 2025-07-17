{
  flake.modules.home-manager.shell =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        powerline-fonts
      ];
      programs.starship = {
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
    };
}
