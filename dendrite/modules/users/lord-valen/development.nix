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
        settings.user =
          let
            inherit (config.programs.git) userName userEmail;
          in
          {
            name = userName;
            email = userEmail;

            ui.default-command = "log";
            signing = {
              behaviour = "drop";
              backend = "ssh";
            };
            git.sign-on-push = true;
          };
      };
      programs.git = {
        userName = "Lord-Valen";
        userEmail = "lord_valen@protonmail.com";

        extraConfig = {
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
