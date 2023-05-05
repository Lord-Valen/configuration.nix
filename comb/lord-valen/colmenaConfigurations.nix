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
  };
}
{
  aspire = {
  };
  autolycus = {
  };
  heracles = {
    deployment.buildOnTarget = true;
  };
  satellite = {
  };
  theseus = {
    deployment.allowLocalDeployment = false;
  };
}
