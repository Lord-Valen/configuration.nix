{
  flake.aspects.upgrade.nixos = {lib,...}: {
    system.autoUpgrade = {
      enable = true;
      dates = lib.mkDefault"02:00";
      randomizedDelaySec = lib.mkDefault "1h";
      flake = "configuration";
    };
  };
  flake.aspects.upgradeReboot.nixos =
    { lib, ... }:
    {
      system.autoUpgrade = {
        allowReboot = true;
        rebootWindow = {
          lower = lib.mkDefault "02:00";
          upper = lib.mkDefault "06:00";
        };
      };
    };
}
