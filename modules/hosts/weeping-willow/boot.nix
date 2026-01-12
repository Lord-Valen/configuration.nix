{
  flake.modules.host.weeping-willow = {
    # Early KMS
    hardware.amdgpu.initrd.enable = true;
    boot = {
      loader = {
        systemd-boot.enable = true;
        efi = {
          canTouchEfiVariables = true;
        };
      };
    };
  };
}
