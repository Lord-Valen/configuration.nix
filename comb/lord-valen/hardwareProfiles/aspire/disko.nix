{
  inputs,
  cell,
}: let
  inherit (inputs) disko;
  inherit (cell) diskoConfigurations;
in {
  _imports = [disko.nixosModules.disko];
  devices = diskoConfigurations.aspire;
}
