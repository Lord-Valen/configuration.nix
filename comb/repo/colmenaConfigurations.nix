{
  inputs,
  cell,
}:
cell.lib.mkColmenaConfigurations cell {} {
  larva = {
    deployment = {
      targetHost = "fe80::47";
      targetPort = 22;
      targetUser = "root";
      allowLocalDeployment = false;
      buildOnTarget = false;
    };
  };
}
