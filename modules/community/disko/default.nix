{
  inputs,
  ...
}:
{
  den.aspects.disko.nixos = {
    imports = [
      inputs.disko.nixosModules.default
    ];
  };
}
