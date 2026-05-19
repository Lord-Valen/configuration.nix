{
  den.aspects.strawberry.homeManager =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        strawberry
      ];
    };
}
