{
  system.autoUpgrade = {
    enable = true;
    dates = "daily";
    operation = "boot";
    randomizedDelaySec = "1h";
    # This is set in the core profile
    flake = "configuration";
  };
}
