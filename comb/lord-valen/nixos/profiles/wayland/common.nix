{
  pkgs,
  lib,
  ...
}: {
  services.greetd = {
    enable = true;
    package = pkgs.greetd.regreet;
  };
  services.displayManager.lightdm.enable = lib.mkForce false;
}
