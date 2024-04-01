{ inputs, cell }:
{
  imports = [ cell.nixosConfigurations.heracles ];
  inherit (cell) bee;
  deployment = cell.deployment // {
    buildOnTarget = true;
    tags = [ "cluster1" ] ++ cell.deployment.tags;
  };
}
