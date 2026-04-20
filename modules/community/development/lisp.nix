{ den, ... }:
{
  den.aspects.lisp = {
    includes = with den.aspects; [ development ];
    provides.lord-valen.includes = [ den.aspects.lisp ];
    elcoco = {
      source = ./lisp.el;
      extraPackages = epkgs: with epkgs; [ lispy ];
    };
  };
}
