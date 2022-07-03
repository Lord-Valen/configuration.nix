{ config, lib, pkgs, ... }:

with lib;

let cfg = config.modules.pipewire;
in {
  options.modules.pipewire = {
    enable = mkEnableOption "Pipewire module";
    alsa = mkOption {
      type = types.bool;
      default = true;
    };
    pulse = mkOption {
      type = types.bool;
      default = true;
    };
    jack = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    sound.enable = true;
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;

    services = {
      pipewire = {
        enable = true;
        alsa.enable = cfg.alsa;
        alsa.support32Bit = cfg.alsa;
        pulse.enable = cfg.pulse;
        jack.enable = cfg.jack;
      };
    };
  };
}
