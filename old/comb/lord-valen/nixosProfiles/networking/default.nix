{
  inputs,
  cell,
  pkgs,
}:
{
  networking = {
    enableIPv6 = true;
    networkmanager = {
      enable = true;
      # wifi.backend = "iwd";
    };
  };

  environment.systemPackages = with pkgs; [
    wget
    curl
    nmap
    nethogs
  ];
}
