{ inputs, cell }:
import inputs.nixpkgs-unstable {
  inherit (inputs.nixpkgs) system;
  inherit (cell.overlays) overlays;
  config = cell.nixpkgsConfig // {
    rocmSupport = true;
  };
}
