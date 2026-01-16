{
  flake.aspects.base.nixos =
    { lib, ... }:
    {
      time.timeZone = lib.mkDefault "Canada/Eastern";
      networking.timeServers = [
        "time.cloudflare.com"
        "time1.mbix.ca"
        "time2.mbix.ca"
        "time3.mbix.ca"
        "time.web-clock.ca"
        "ohio.time.system76.com"
      ];
      services.ntpd-rs = {
        enable = true;
        settings = {
          synchronization.algorithm.step-threshold = 10;
          source = [
            {
              address = "time.cloudflare.com";
              mode = "nts";
            }
            {
              address = "time1.mbix.ca";
              mode = "nts";
            }
            {
              address = "time2.mbix.ca";
              mode = "nts";
            }
            {
              address = "time3.mbix.ca";
              mode = "nts";
            }
            {
              address = "time.web-clock.ca";
              mode = "nts";
            }
            {
              address = "ohio.time.system76.com";
              mode = "nts";
            }
          ];
        };
      };
    };
}
