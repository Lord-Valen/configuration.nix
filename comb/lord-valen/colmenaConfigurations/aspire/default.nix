{ inputs, cell }:
{
  imports = [ cell.nixosConfigurations.aspire ];
  inherit (cell) bee deployment;
}
