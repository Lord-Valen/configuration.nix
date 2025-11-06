{ self, config, ... }:
{
  flake.modules.nixos.development =
    with config.flake.modules.homeManager;
    [
      development
      config.flake.modules.homeManager."lord-valen/development"
    ]
    |> self.lib.importManyForUser "lord-valen";

  flake.modules.homeManager."lord-valen/development" =
    { config, ... }:
    {
      programs.jujutsu = {
        settings = {
          user = {
            inherit (config.programs.git.settings.user) name email;
          };

          ui.default-command = "log";
          signing = {
            behaviour = "drop";
            backend = "ssh";
            key = "~/.ssh/id_ed25519.pub";
          };
          git.sign-on-push = true;
        };
      };
      programs.git = {
        settings = {
          user = {
            name = "Lord-Valen";
            email = "lord_valen@protonmail.com";
          };
          github.user = "Lord-Valen";
          gitlab.user = "Lord-Valen";
          init.defaultBranch = "main";
          merge.conflictStyle = "zdiff3";

          fetch = {
            prune = true;
            pruneTags = true;
          };

          pull.rebase = true;
          push = {
            autoSetupRemote = true;
            default = "current";
          };

          remote.pushDefault = "Lord-Valen";
        };

        signing = {
          signByDefault = true;
          format = "ssh";
        };
      };
    };
}
