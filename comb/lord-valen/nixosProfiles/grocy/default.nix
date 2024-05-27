{
  services.grocy = {
    enable = true;
    hostName = "grocy";
    nginx.enableSSL = false; # TODO
    settings = {
      currency = "CAD";
      calendar.firstDayOfWeek = 0;
    };
  };
}
