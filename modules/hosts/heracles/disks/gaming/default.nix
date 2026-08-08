{
  den.aspects.heracles.nixos = { lib, ... }: {
    fileSystems."/home/lord-valen/Games".neededForBoot = lib.mkForce false;
    disko.devices = {
      disk.nvme = lib.importTOML ./nvme.toml;
      disk.hdd = lib.importTOML ./hdd.toml;
      bcachefs_filesystems.gaming = lib.importTOML ./gaming.toml;
    };
  };
}
