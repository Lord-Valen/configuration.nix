{ inputs, cell }:
{
  _imports = [ inputs.disko.nixosModules.disko ];
  devices = cell.diskoConfigurations.heracles;
}
