{ config, ... }:
{
  flake.modules.homeManager.nushell = {
    imports = with config.flake.modules.homeManager; [
      shell
    ];
    programs.nushell = {
      enable = true;
      configFile.source = ./config.nu;
      settings = {
        show_banner = false;
        filesize.unit = "binary";
      };
    };
  };
}
