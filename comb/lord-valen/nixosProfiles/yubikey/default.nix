{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
in {
  environment.systemPackages = with nixpkgs; [
    yubikey-manager
  ];

  services.pcscd.enable = true;
}
