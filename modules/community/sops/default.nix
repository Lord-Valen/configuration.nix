{ den, inputs, ... }:
{
  den.aspects.sops = {
    nixos =
      { ... }:
      {
        imports = [ inputs.sops-nix.nixosModules.sops ];
        sops.age.keyFile = "/var/lib/sops-nix/key.txt";
      };
  };
}
