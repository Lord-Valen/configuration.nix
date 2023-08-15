{
  inputs,
  cell,
}: {
  services = {
    p2pool = import ./services/p2pool;
    openttd = import ./services/openttd;
  };
}
