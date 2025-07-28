{
  flake.modules.nixos.pipewire =
    {
      pkgs,
      ...
    }:
    {
      environment.systemPackages = with pkgs; [
        pavucontrol
        pwvucontrol
        helvum
      ];
    };
}
