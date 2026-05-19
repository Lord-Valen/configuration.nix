{
  den.aspects.plugins.homeManager =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        geonkick
        distrho-ports
      ];
    };
}
