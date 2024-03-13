{ inputs, cell }:
let
  inherit (inputs) nixpkgs;
in
{
  networking = {
    enableIPv6 = true;
    wireless.iwd.enable = true;
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
    };
  };

  environment.systemPackages = with nixpkgs; [
    wget
    curl
    nmap
    nethogs
  ];
}
