{
  inputs,
  cell,
  pkgs,
}:
{
  systemPackages = with pkgs; [
    pavucontrol
    #pwvucontrol
    helvum
    easyeffects
  ];
}
