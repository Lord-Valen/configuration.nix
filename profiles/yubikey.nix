{
  config,
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = [
    pkgs.yubikey-manager
  ];

  services = {
    yubikey-agent.enable = true;
    pcscd.enable = true;
  };
}
