{ den, ... }:
{
  den.aspects.ai = {
    includes = with den.aspects; [ basics ];
    elcoco = {
      source = ./ai.el;
      extraPackages = epkgs: with epkgs; [ agent-shell ];
    };
  };
}
