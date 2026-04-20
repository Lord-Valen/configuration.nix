{ den, ... }:
{
  den.aspects.lisp = {
    provides.lord-valen.includes = [ den.aspects.lisp ];
    includes = with den.aspects; [ development ];
    elcoco = {
      source = ./lisp.el;
      extraPackages =
        epkgs: with epkgs; [
          (lispy.overrideAttrs (old: {
            packageRequires = (old.packageRequires or [ ]) ++ [
              swiper
              iedit
              zoutline
              avy
              hydra
            ];
          }))
        ];
    };
  };
}
