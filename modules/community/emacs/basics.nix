{
  den.aspects.basics.elcoco = {
    source = ./basics.el;
    extraPackages = epkgs: with epkgs; [
      no-littering meow
      moody minions
      vertico marginalia corfu orderless
      embark consult embark-consult
      helpful which-key
      indent-bars rainbow-delimiters
      magit vc-jj
      apheleia command-log-mode direnv treemacs
    ];
  };
}
