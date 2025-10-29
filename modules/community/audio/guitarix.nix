{
  flake.modules.homeManager.guitarix =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [ guitarix ];
    };
}
