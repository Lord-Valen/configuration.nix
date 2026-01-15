{
  flake.modules.nixos.autolycus.boot = {
    # Early KMS
    kernelModules = [ "i915" ];
    loader = {
      limine.enable = true;
      efi = {
        canTouchEfiVariables = true;
      };
    };
  };
}
