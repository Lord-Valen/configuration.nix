{
  inputs,
  cell,
  pkgs,
}:
{
  avahi = {
    enable = true;
    publish = {
      enable = true;
      userServices = true;
    };
  };
  xserver.desktopManager.retroarch = {
    enable = true;
    package = pkgs.retroarchFull;
  };
}
