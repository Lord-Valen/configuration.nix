{
  flake.modules.homeManager.heroic =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [ heroic ];
    };
}
