{ config, ... }:
{
  flake.modules.homeManager.shell =
    {
      pkgs,
      ...
    }:
    {
      imports = with config.flake.modules.homeManager; [
        fonts
        comma
      ];
      programs.bash.enable = true;

      home.packages = with pkgs; [
        ripgrep
        bottom
        carapace
        bat
        ouch
      ];
    };
}
