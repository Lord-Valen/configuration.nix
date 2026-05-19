{
  # TODO: add default config values in the snapper module
  den.aspects.btrfs.nixos.services.snapper = {
    snapshotRootOnBoot = true;
    persistentTimer = true;
  };
}
