{
  flake.modules.homeManager.brave =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        brave
      ];
    };
}
