{
  config,
  lib,
  pkgs,
  ...
}: {
  console.useXkbConfig = true;
  services.xserver.xkbVariant = "colemak_dh";
}
