{
  kernelModules = ["kvm_amd"];
  initrd.availableKernelModules = ["xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod"];
  loader = {
    systemd-boot = {
      enable = true;
      memtest86.enable = true;
    };
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
  };
}
