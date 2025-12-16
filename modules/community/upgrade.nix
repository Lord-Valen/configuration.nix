{
  flake.aspects.upgrade.nixos = {
    system.autoUpgrade = {
      enable = true;
      dates = "02:00";
      randomizedDelaySec = "1h";
      flake = "configuration";
    };
  };
  flake.aspects.upgradeReboot.nixos = {
    system.autoUpgrade = {
      allowReboot = true;
      rebootWindow = {
        lower = "02:00";
        upper = "06:00";
      };
    };
  };
}
