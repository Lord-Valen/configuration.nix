{pkgs, ...}: {
  environment.systemPackages = [
    pkgs.yubikey-manager
  ];

  services.pcscd.enable = true;
}
