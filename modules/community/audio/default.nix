{ den, ... }:
{
  den.aspects.audio = {
    includes = with den.aspects; [ browser-audio ];

    provides.lord-valen = {
      includes = with den.aspects; [
        zrythm
        plugins
        supercollider
        vcv
        guitarix
      ];
    };
  };
}
