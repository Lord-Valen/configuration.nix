{
  kernelModules = ["kvm-amd"];
  initrd.availableKernelModules = [
    "xhci_pci"
    "ahci"
    "ehci_pci"
    "usb_storage"
    "sd_mod"
    "rtsx_pci_sdmmc"
  ];
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
