{ config, ... }:
{
  flake.modules.home-manager.shell =
    {
      pkgs,
      ...
    }:
    {
      imports = with config.flake.modules.home-manager; [
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
