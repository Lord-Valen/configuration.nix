{
  flake.modules.hosts.theseus.boot = {
    # Early KMS
    kernelModules = [ "amdgpu" ];
    loader = {
      systemd-boot.enable = true;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
    };
  };
}
