{
  den.aspects.heracles.nixos.disko.devices.disk.sda = {
    device = "/dev/disk/by-id/ata-KINGSTON_SA400S37480G_50026B7785A31CC6";
    type = "disk";
    content = {
      type = "gpt";
      partitions = {
        EFI = import ./_BOOT.nix;
        MAIN = import ./_MAIN.nix;
      };
    };
  };
}
