{
  flake.modules.nixos.btrfs =
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
