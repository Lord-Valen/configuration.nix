{
  config,
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [carla];
  services.pipewire.jack.enable = true;
}
