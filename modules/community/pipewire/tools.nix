{
  den.aspects.pipewire.nixos =
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
