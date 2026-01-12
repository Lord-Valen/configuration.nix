{
  flake.modules.nixos.theseus.boot = {
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
