{
  config,
  lib,
  pkgs,
  ...
}: {
  services = {
    syncthing = {
      enable = true;
      group = "users";
      devices = {
        "oracle".id = "2N6Y4QI-PFZSERX-ECZRCQ3-2WZTKLO-G5G25IP-AMBFAY5-MQ5DSKP-KT2QGAD";
      };
    };
  };
}
