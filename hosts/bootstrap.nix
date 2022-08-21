{ profiles, ... }:
{
  imports = [
    # profiles.networking
    profiles.core.nixos
    profiles.users.root # make sure to configure ssh keys
    profiles.users.nixos
  ];

  system.stateVersion = "22.05";

  boot.loader.systemd-boot.enable = true;

  # Required, but will be overridden in the resulting installer ISO.
  fileSystems."/" = { device = "/dev/disk/by-label/nixos"; };
}
