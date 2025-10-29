{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
  home.sessionPath = [ "$HOME/.local/bin" ];
}
