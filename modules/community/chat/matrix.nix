{
  flake.modules.homeManager.matrix =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [ element-desktop ];
    };
}
