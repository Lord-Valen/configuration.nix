{ pkgs }:
{
  fonts.fontconfig.enable = true;

  programs.emacs = {
    enable = true;
    package = pkgs.emacs29;
    extraPackages =
      epkgs: with epkgs; [
        # :term vterm
        vterm
        treesit-grammars.with-all-grammars
      ];
  };

  services.emacs = {
    enable = true;
    defaultEditor = true;
    socketActivation.enable = true;
    client.enable = true;
  };
}
