{ inputs, cell }:
{
  imports = [
    cell.bee
    cell.nixosConfigurations.satellite
  ];
  inherit (cell) deployment;
}
