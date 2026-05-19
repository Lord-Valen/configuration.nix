{
  den.aspects.zrythm.homeManager =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [ zrythm ];
    };
}
