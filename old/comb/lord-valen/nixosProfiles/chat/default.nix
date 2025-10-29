{
  inputs,
  cell,
  pkgs,
}:
{
  environment.systemPackages = with pkgs; [
    webcord
    element-desktop
  ];
}
