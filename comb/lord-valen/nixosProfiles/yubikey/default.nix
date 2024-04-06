{
  inputs,
  cell,
  pkgs,
}:
{
  environment.systemPackages = with pkgs; [ yubikey-manager ];

  services.pcscd.enable = true;
}
