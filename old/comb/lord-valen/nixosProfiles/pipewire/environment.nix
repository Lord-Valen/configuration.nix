{
  pkgs,
}:
{
  systemPackages = with pkgs; [
    pavucontrol
    pwvucontrol
    helvum
  ];
}
