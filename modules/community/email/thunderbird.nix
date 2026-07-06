{
  den.aspects.thunderbird.homeManager =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [ thunderbird ];
    };
}
