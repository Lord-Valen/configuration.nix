{ inputs, cell }:
let
  inherit (inputs) common;
  inherit (common.deployment) tags;
in
{
  imports = [ cell.nixosConfigurations.heracles ];
  inherit (common) bee;
  deployment.buildOnTarget = true;
  deployment.tags = [ "cluster1" ] ++ tags;
}
