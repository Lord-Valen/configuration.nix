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
        settings = { inherit (config.programs.git) userName userEmail; };
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
          key = "C5129E27E5CCA729";
          signByDefault = true;
        };
      };
    };
}
