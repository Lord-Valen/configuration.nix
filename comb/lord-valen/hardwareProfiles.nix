{
  inputs,
  cell,
}: let
  defaults = {
    hardware.opengl.driSupport32Bit = true;
    hardware.enableRedistributableFirmware = true;
  };
in {
  autolycus = {
    imports = with inputs.nixos-hardware.nixosModules; [
      defaults
      lenovo-thinkpad-t420
    ];

    boot.initrd.availableKernelModules = []; # TODO
  };

  heracles = {
    imports = with inputs.nixos-hardware.nixosModules; [
      defaults
      common-pc
      common-cpu-amd-pstate
      common-gpu-amd
    ];

    services.xserver.xrandrHeads = ["HDMI-1" "DP-1"];

    boot = {
      kernelModules = ["kvm_amd"];
      initrd.availableKernelModules = ["xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod"];
    };
  };

  satellite = {
    imports = with inputs.nixos-hardware.nixosModules; [
      defaults
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

  theseus = {
    imports = with inputs.nixos-hardware.nixosModules; [
      defaults
      common-pc
      common-cpu-intel-sandy-bridge
      common-gpu-amd-southern-islands
    ];

    boot = {
      kernelModules = ["kvm-intel"];
      initrd.availableKernelModules = [
        "ehci_pci"
        "ahci"
        "xhci_pci"
        "usb_storage"
        "usbhid"
        "sd_mod"
        "sr_mod"
      ];
    };
  };
}
