{
  inputs,
  cell,
}: let
  inherit (inputs) common;
  inherit (common.deployment) tags;
in {
  imports = [cell.nixosConfigurations.theseus];
  inherit (common) bee;
  deployment.allowLocalDeployment = false;
  deployment.tags = tags ++ ["cluster1"];
}
