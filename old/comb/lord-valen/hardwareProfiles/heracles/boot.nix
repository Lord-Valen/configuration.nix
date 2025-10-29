{
  kernelModules = [ "kvm_amd" ];
  initrd.availableKernelModules = [
    "xhci_pci"
    "ahci"
    "usb_storage"
    "usbhid"
    "uas"
    "sd_mod"
  ];
  loader = {
    systemd-boot = {
      enable = true;
      memtest86.enable = true;
    };
    efi = {
      canTouchEfiVariables = true;
    };
  };
}
