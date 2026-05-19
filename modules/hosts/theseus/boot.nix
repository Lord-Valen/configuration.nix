{
  den.aspects.theseus.nixos.boot = {
    # Early KMS
    kernelModules = [ "amdgpu" ];
    loader = {
      systemd-boot.enable = true;
      efi = {
        canTouchEfiVariables = true;
      };
    };
  };
}
