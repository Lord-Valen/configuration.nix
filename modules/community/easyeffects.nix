{
  den.aspects.easyeffects.homeManager =
    { pkgs, ... }:
    {
      services.easyeffects.enable = true;
      home.packages = with pkgs; [
        easyeffects
      ];
    };
}
