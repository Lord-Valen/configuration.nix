{
  flake.modules.homeManager.easyeffects =
    { pkgs, ... }:
    {
      services.easyeffects.enable = true;
      home.packages = with pkgs; [
        easyeffects
      ];
    };
}
