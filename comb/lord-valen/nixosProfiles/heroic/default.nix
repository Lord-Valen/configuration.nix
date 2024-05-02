{
  inputs,
  cell,
  pkgs,
}:
{
  environment.systemPackages = with pkgs; [ heroic ];
}
