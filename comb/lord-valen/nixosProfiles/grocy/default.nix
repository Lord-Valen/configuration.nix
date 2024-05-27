{
  networking.firewall.allowedTCPPorts = [ 80 ];
  networking.firewall.allowedUDPPorts = [ 80 ];
  services.grocy = {
    enable = true;
    hostName = "grocy.home *.grocy.home";
    nginx.enableSSL = false; # TODO
    settings = {
      currency = "CAD";
      calendar.firstDayOfWeek = 0;
    };
  };
}
