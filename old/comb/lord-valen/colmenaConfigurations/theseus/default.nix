{ inputs, cell }:
{
  imports = [
    cell.bee
    cell.nixosConfigurations.theseus
  ];
  deployment = cell.deployment // {
    allowLocalDeployment = false;
    tags = cell.deployment.tags ++ [ "cluster1" ];
  };
}
