{
  fonts.fontconfig.enable = true;

  programs.emacs = {
    enable = true;
    extraPackages =
      epkgs: with epkgs; [
        meow

        doom-modeline

        vertico
        savehist
        marginalia
        corfu
        embark
        consult
        embark-consult
        orderless

        which-key

        melpaStable.magit
        melpaStable.tree-sitter-langs
        treesit-grammars.with-all-grammars

        command-log-mode
      ];
  };

  services.emacs = {
    enable = true;
    defaultEditor = true;
    socketActivation.enable = true;
    client.enable = true;
  };
}
