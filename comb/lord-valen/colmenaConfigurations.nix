{
  inputs,
  cell,
}:
cell.lib.mkColmenaConfigurations
cell
{
  bee.system = "x86_64-linux";
  bee.pkgs = inputs.nixpkgs;
  deployment = {
    allowLocalDeployment = true;
    tags = ["all"];
  };
}
{
  aspire = {
  };
  # autolycus = {
  # };
  heracles = {
    deployment.buildOnTarget = true;
    # TODO: Do not dumb here
    deployment.tags = ["all" "cluster1"];
  };
  satellite = {
  };
  theseus = {
    deployment.allowLocalDeployment = false;
    deployment.tags = ["all" "cluster1"];
  };
}
