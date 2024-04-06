{
  inputs,
  cell,
  pkgs,
}:
{
  networking = {
    enableIPv6 = true;
    wireless.iwd.enable = true;
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
    };
  };

  environment.systemPackages = with pkgs; [
    wget
    curl
    nmap
    nethogs
  ];
}
