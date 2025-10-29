{
  # TODO: add default config values in the snapper module
  flake.modules.nixos.btrfs.services.snapper = {
    snapshotRootOnBoot = true;
    persistentTimer = true;
  };
}
