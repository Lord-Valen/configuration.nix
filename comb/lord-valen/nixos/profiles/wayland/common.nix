{
  pkgs,
  lib,
  ...
}: {
  services.greetd = {
    enable = true;
    package = pkgs.greetd.regreet;
  };
  programs.gnupg.agent.pinentryFlavor = "gtk2";
  services.xserver.displayManager.lightdm.enable = lib.mkForce false;
}
