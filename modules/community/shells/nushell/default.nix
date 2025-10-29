{ config, ... }:
{
  flake.modules.homeManager.nushell = {
    imports = with config.flake.modules.homeManager; [
      shell
    ];
    programs.nushell = {
      enable = true;
      configFile.source = ./config.nu;
      envFile.source = ./env.nu;
    };
  };
}
