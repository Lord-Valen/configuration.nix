{ inputs, cell }:
{
  imports = [
    cell.bee
    cell.nixosConfigurations.heracles
  ];
  deployment = cell.deployment // {
    buildOnTarget = true;
    tags = [ "cluster1" ] ++ cell.deployment.tags;
  };
}
