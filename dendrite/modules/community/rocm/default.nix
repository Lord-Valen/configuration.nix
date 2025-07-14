{
  flake.modules.nixos.rocm = {
    nixpkgs.config.rocmSupport = true;
  };
}
