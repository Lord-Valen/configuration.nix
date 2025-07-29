{
  flake.modules.homeManager.development =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        gitbutler
        devenv
      ];

      home.sessionPath = [ "$HOME/.local/bin" ];
      programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
      };
      programs.git.enable = true;
      programs.jujutsu = {
        enable = true;
        ediff = false;
        settings = {
          signing = {
            behaviour = "drop";
            backend = "gpg";
          };
          git.sign-on-push = true;
        };
      };
    };
}
