{
  inputs,
  cell,
}: {
  heracles = {
    imports = with inputs.nixos-hardware.nixosModules; [
      common-pc
      common-cpu-amd-pstate
      common-gpu-amd
    ];

    services.xserver.xrandrHeads = [
      "HDMI-A-0"
      "DisplayPort-0"
    ];

    boot = {
      kernelModules = ["kvm_amd"];
      initrd.availableKernelModules = [
        "xhci_pci"
        "ahci"
        "usbhid"
        "usb_storage"
        "sd_mod"
      ];
    };

    hardware.opengl.driSupport32Bit = true;
  };

  satellite = {
    imports = with inputs.nixos-hardware.nixosModules; [
      common-pc-laptop-hdd
      common-cpu-amd
    ];

    boot.initrd.availableKernelModules = [
      "ahci"
      "ohci_pci"
      "ehci_pci"
      "usb_storage"
      "ums_realtek"
      "sd_mod"
      "sr_mod"
    ];
  };
}
