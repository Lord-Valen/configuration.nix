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
        "Oracle".id = "2N6Y4QI-PFZSERX-ECZRCQ3-2WZTKLO-G5G25IP-AMBFAY5-MQ5DSKP-KT2QGAD";
        "Pythia".id = "U4T26LJ-76QPOOX-N7ITRSK-YUXDEFB-5ICOBOM-TC6V5Z5-5VDFFK5-BUEWFQH";
      };
    };
  };
}
