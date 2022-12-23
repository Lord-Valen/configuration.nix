{
  self,
  inputs,
  ...
}: {
  modules = with inputs; [];
  exportedModules = [
    ./digga.nix
  ];
}
