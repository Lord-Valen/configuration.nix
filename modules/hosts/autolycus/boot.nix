{ config, ... }:
{
  flake.aspects.autolycus.nixos = {
    imports = [
      config.flake.modules.nixos.secureBoot
    ];
    boot = {
      # Early KMS
      kernelModules = [ "i915" ];
      loader = {
        efi.canTouchEfiVariables = true;
      };
    };
  };
}
