{
  flake.modules.nixos.autolycus.disko.devices.disk.nvme0n1 = {
    device = "/dev/nvme0n1";
    type = "disk";
    content = {
      type = "gpt";
      partitions = {
        EFI = import ./_EFI.nix;
        MAIN = import ./_MAIN.nix;
      };
    };
  };
}
