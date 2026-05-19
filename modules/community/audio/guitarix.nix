{
  den.aspects.guitarix.homeManager =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [ guitarix ];
    };
}
