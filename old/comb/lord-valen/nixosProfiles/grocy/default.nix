{
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
