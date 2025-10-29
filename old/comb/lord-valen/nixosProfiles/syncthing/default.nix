{
  inputs,
  cell,
  config,
  lib,
}:
let
  inherit (config.networking) hostName;
in
{
  services = {
    syncthing = {
      enable = true;
      group = "users";
      settings.devices = {
        "Pythia" = {
          id = "U4T26LJ-76QPOOX-N7ITRSK-YUXDEFB-5ICOBOM-TC6V5Z5-5VDFFK5-BUEWFQH";
          introducer = true;
          autoAcceptFolders = true;
        };
        "Autolycus" = lib.mkIf (hostName != "autolycus") {
          id = "UEH7TKO-70JPHVY-Z26FJFF-QYKSW5J-SE2KIBU-YDNKJ4U-YCIGCAJ-XQ4STAU";
        };
        "lvAutolycus" = lib.mkIf (hostName != "autolycus") {
          id = "OUKE7M7-JXGJNQZ-YHV522X-SR43FKG-YIUMSEH-OSLULFY-AODTU4X-OF7V4AI";
        };
        "Heracles" = lib.mkIf (hostName != "heracles") {
          id = "TA6LIVP-C6CPJ6S-GTVYJ62-YXT3BWL-67U6ND7-ISZGJJK-ASTROVP-DGBKKQB";
        };
        "lvHeracles" = lib.mkIf (hostName != "heracles") {
          id = "PYBY33V-VYJN4YU-L67K3CX-2HNOZYA-UW3HXRW-Q6IRUEZ-UY6DBPO-JY47NQ6";
        };
        "Theseus" = lib.mkIf (hostName != "theseus") {
          id = "JFJTOJX-S6ITXDO-PJ5CEYI-ZTCAUFJ-7J22EFK-H7VX4AA-KJZ3QLW-XED4WQG";
        };
      };
    };
  };
}
