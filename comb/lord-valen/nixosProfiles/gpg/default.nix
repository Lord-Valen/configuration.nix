{
  inputs,
  cell,
  pkgs,
  lib,
}:
{
  hardware.gpgSmartcards.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-gtk2;
  };

  #services.gnome.gnome-keyring.enable = lib.mkForce false;
}
