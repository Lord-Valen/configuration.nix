{
  flake.modules.hosts.heracles = {
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
