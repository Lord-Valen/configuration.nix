{ inputs, cell }:
{
  imports = [ cell.nixosConfigurations.satellite ];
  inherit (cell) bee deployment;
}
