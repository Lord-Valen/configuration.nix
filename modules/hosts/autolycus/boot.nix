{
  den.aspects.autolycus.nixos = {
    boot = {
      # Early KMS
      kernelModules = [ "i915" ];
      loader.efi.canTouchEfiVariables = true;
    };
  };
}
