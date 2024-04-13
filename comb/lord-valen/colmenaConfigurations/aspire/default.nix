{ inputs, cell }:
{
  imports = [
    cell.bee
    cell.nixosConfigurations.aspire
  ];
  inherit (cell) deployment;
}
