{ inputs, cell }:
{
  imports = [
    cell.bee
    cell.nixosConfigurations.autolycus
  ];
  inherit (cell) deployment;
}
