{ suites, profiles, ... }:

{
  imports = suites.laptop ++ (with profiles; [ latex ]);

  system.stateVersion = "22.05";

  boot = {
    loader = {
      grub = {
        enable = true;
        device = "/dev/sda";
        useOSProber = true;
        enableCryptodisk = true;
      };
    };

    initrd = {
      availableKernelModules = [
        "ahci"
        "ohci_pci"
        "ehci_pci"
        "usb_storage"
        "ums_realtek"
        "sd_mod"
        "sr_mod"
      ];

      secrets."/crypto_keyfile.bin" = null;
      luks.devices = {
        "luks-97a51f6e-16a9-488f-a23f-affd64965a85" = {
          device = "/dev/disk/by-uuid/97a51f6e-16a9-488f-a23f-affd64965a85";
          keyFile = "/crypto_keyfile.bin";
        };
        # Enable swap on luks
        "luks-66cbab88-e395-45bd-bb1e-78fb065c623a" = {
          device = "/dev/disk/by-uuid/66cbab88-e395-45bd-bb1e-78fb065c623a";
          keyFile = "/crypto_keyfile.bin";
        };
      };
    };

    kernelModules = [ "kvm-amd" ];
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/56bab247-0cd4-489f-8f6a-2336b3940182";
    fsType = "ext4";
  };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/5b455084-e717-4ded-88c2-9714031ccad0"; }];

  hardware.cpu.amd.updateMicrocode = true;
}
