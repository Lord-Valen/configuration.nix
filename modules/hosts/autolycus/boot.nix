{
  flake.modules.hosts.autolycus.boot = {
    # Early KMS
    kernelModules = [ "i915" ];
    loader = {
      systemd-boot.enable = true;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
    };
  };
}
