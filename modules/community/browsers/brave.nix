{
  den.aspects.brave.homeManager =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        brave
      ];
    };
}
