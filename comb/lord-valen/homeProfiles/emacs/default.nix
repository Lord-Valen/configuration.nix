{
  fonts.fontconfig.enable = true;

  programs.emacs = {
    enable = true;
    extraPackages =
      epkgs: with epkgs; [
        use-package
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

	rainbow-delimiters
	lispy
	nix-ts-mode
	helpful
	apheleia
	eglot
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
