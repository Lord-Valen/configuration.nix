{
  inputs,
  cell,
  pkgs,
}:
{
  packages = with pkgs; [ mpc-cli ];
}
