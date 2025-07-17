{ config, ... }:
{
  flake.modules.home-manager.nushell = {
    imports = with config.flake.modules.home-manager; [
      shell
    ];
    programs.nushell = {
      enable = true;
      configFile.source = ./config.nu;
      envFile.source = ./env.nu;
    };
  };
}
