{
  flake.modules.homeManager.zrythm =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [ zrythm ];
    };
}
