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
      loader = {
        grub = {
          enable = true;
          efiSupport = true;
          device = "nodev";
          useOSProber = true;
        };
        efi = {
          canTouchEfiVariables = true;
          efiSysMountPoint = "/boot/efi";
        };
      };

      kernelModules = ["kvm_amd"];
      initrd = {
        availableKernelModules = [
          "xhci_pci"
          "ahci"
          "usbhid"
          "usb_storage"
          "sd_mod"
        ];
      };
    };

    hardware.opengl.driSupport32Bit = true;
  };
}
