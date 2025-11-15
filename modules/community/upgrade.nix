{
  flake.aspects.upgrade.nixos = {
    system.autoUpgrade = {
      enable = true;
      dates = "daily";
      operation = "boot";
      randomizedDelaySec = "1h";
      flake = "configuration";
    };
  };
}
