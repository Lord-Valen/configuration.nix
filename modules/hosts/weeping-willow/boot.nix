{
  flake.modules.hosts.weeping-willow = {
    # Early KMS
    # hardware.amdgpu.initrd.enable = true;
    boot = {
      loader = {
        grub = {
          enable = true;
          efiSupport = true;
          efiInstallAsRemovable = true;
        };
      };
    };
  };
}
