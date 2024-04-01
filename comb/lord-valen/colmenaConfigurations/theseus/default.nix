{ inputs, cell }:
{
  imports = [ cell.nixosConfigurations.theseus ];
  inherit (cell) bee;
  deployment = cell.deployment // {
    allowLocalDeployment = false;
    tags = cell.deployment.tags ++ [ "cluster1" ];
  };
}
