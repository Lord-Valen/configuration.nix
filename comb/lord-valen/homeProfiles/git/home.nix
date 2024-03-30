{
  inputs,
  cell,
  pkgs,
}:
{
  packages = with pkgs; [
    gh
    glab
    codeberg-cli
    tea
    hut
  ];
}
