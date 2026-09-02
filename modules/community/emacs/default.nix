{ inputs, ... }:
{
  den.aspects.emacs-overlay.nixos = {
    nixpkgs.overlays = [ inputs.emacs-overlay.overlays.package ];
  };
  den.aspects.emacs = {
    homeManager = { ... }: {
      imports = [ inputs.elcoco.homeModules.default ];
      elcoco.enable = true;
      services.emacs = {
        enable = true;
        defaultEditor = true;
        socketActivation.enable = true;
        client.enable = true;
      };
      stylix.targets.emacs.colors.enable = false;
    };
    elcoco = {
      source = ./basics.el;
      extraPackages =
        epkgs: with epkgs; [
          no-littering
          meow
          moody
          minions
          vertico
          marginalia
          corfu
          orderless
          embark
          consult
          embark-consult
          helpful
          which-key
          indent-bars
          rainbow-delimiters
          magit
          vc-jj
          apheleia
          command-log-mode
          direnv
          treemacs
          catppuccin-theme
        ];
    };
  };
}
