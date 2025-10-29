{ cell }:
{
  imports = [
    cell.bee
    cell.nixosConfigurations.nephele
  ];
  deployment = cell.deployment // {
    allowLocalDeployment = false;
    tags = cell.deployment.tags ++ [ "cluster1" ];
  };
}
