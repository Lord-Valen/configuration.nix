{
  inputs,
  cell,
  config,
}: let
  inherit (inputs.nixpkgs) lib;
  inherit (config.networking) hostName;
in {
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
        "Aspire" = lib.mkIf (hostName != "aspire") {
          id = "W6RD47K-57IC3EK-5RDOGTU-UU4LH3W-LNF24R7-P6I2A4B-TLZJZM3-FM47IQS";
        };
        "lvAspire" = lib.mkIf (hostName != "aspire") {
          id = "UTZZ4BA-T64UUD5-GM4LMLC-BPZQUMD-T6M3UUK-DYPOKDF-3WYKHBN-6B67TQF";
        };
        "Heracles" = lib.mkIf (hostName != "heracles") {
          id = "P24GAXD-4KBICX2-ZT4UP66-TF4EIOK-M7MQLQK-QW4QNWC-ALONBBQ-QGVICQB";
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
