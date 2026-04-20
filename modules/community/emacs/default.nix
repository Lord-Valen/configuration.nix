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
    };
  };
}
