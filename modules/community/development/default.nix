{
  flake.modules.homeManager.development =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
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
      };
    };
}
