{
  pkgs ? import <nixpkgs> { },
  lib ? pkgs.lib,
  ...
}:
{
  allowlistedLicenses = with lib.licenses; [
    fsl11Mit
    fsl11Asl20
  ];
}
