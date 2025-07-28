{
  flake.modules.nixos.keepOutputs.nix.settings = {
    keep-derivations = true;
    keep-outputs = true;
  };
}
