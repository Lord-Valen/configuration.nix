{
  den.aspects.btrfs.nixos =
    {
      pkgs,
      ...
    }:
    {
      environment.systemPackages = with pkgs; [
        btrfs-progs
        btdu
      ];
    };
}
