{ config, ... }:
{
  flake.modules.home-manager.nushell = {
    imports = with config.flake.modules.home-manager; [
      shell
    ];
    programs.nushell = {
      enable = true;
      configFile.source = ./_config.nu;
      envFile.source = ./_env.nu;
    };
  };
}
