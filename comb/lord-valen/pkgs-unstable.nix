{ inputs, cell }:
import inputs.nixpkgs-unstable {
  inherit (inputs.nixpkgs) system;
  config = cell.nixpkgsConfig;
}
