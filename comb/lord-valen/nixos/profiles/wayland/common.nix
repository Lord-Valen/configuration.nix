{
  pkgs,
  lib,
  ...
}: {
  services.greetd = {
    enable = true;
    package = pkgs.greetd.regreet;
  };
  services.xserver.displayManager.lightdm.enable = lib.mkForce false;
}
