{ den, ... }:
{
  den.aspects.godot = {
    includes = with den.aspects; [ development ];
    elcoco = {
      source = ./gdscript.el;
      extraPackages = epkgs: with epkgs; [ gdscript-mode ];
    };
  };
}
