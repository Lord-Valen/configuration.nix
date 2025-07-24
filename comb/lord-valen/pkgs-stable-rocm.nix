{ inputs, cell }:
import inputs.nixpkgs-stable {
  inherit (inputs.nixpkgs) system;
  inherit (cell.overlays) overlays;
  config = cell.nixpkgsConfig // {
    rocmSupport = true;
  };
}
