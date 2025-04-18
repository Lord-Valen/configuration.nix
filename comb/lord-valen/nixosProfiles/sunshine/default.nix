{
  inputs,
  cell,
  pkgs,
}:
{
  imports = with cell.nixosProfiles; [ avahi ];

  services.sunshine = {
    enable = true;
    autoStart = false;
    openFirewall = true;
    capSysAdmin = true;
  };
}
