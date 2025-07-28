{
  flake.modules.homeManager.photography =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [ darktable ];
    };
}
