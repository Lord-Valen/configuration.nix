{
  flake.modules.homeManager.plugins =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        geonkick
        distrho-ports
      ];
    };
}
