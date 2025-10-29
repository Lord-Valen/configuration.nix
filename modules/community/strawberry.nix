{
  flake.modules.homeManager.strawberry =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        strawberry
      ];
    };
}
