{
  den.aspects.matrix.homeManager =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [ element-desktop ];
    };
}
