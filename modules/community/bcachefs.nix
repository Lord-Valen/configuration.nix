{
  den.aspects.bcachefs.nixos = { pkgs, ... }: {
    boot.supportedFilesystems.bcachefs = true;
  };
}
