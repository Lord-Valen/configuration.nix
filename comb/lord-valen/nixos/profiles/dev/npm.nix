{
  imports = [./inkscape.nix];

  # Enables us to use `npm link` without running into permissions issues
  programs.npm.enable = true;

  # Host test sites
  networking.firewall = {
    allowedTCPPorts = [3000];
    allowedUDPPorts = [3000];
  };
}
