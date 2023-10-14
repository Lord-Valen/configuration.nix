{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
in {
  environment.systemPackages = with nixpkgs; [monero-gui];
  services.monero.enable = true;
}
