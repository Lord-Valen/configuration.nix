{
  config,
  lib,
  pkgs,
  ...
}: {
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  environment.systemPackages = [
    pkgs.pavucontrol
    pkgs.carla
  ];

  services = {
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;
    };
  };
}
