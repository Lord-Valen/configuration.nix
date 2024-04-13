{ inputs, cell }:
import inputs.nixpkgs-stable {
  inherit (inputs.nixpkgs) system;
  config = cell.nixpkgsConfig;
}
