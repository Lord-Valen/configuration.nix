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
      devices = {
        "Pythia" = {
          id = "U4T26LJ-76QPOOX-N7ITRSK-YUXDEFB-5ICOBOM-TC6V5Z5-5VDFFK5-BUEWFQH";
          introducer = true;
          autoAcceptFolders = true;
        };
        "Aspire" = lib.mkIf (hostName != "aspire") {
          id = "Q6BQBZP-W3GCDFN-LW7FQOV-EUIMTYH-AEEODXN-R6WDRK3-UHDAR2O-JWVKKAW";
        };
        "Heracles" = lib.mkIf (hostName != "heracles") {
          id = "P24GAXD-4KBICX2-ZT4UP66-TF4EIOK-M7MQLQK-QW4QNWC-ALONBBQ-QGVICQB";
          introducer = true;
        };
        "Theseus" = lib.mkIf (hostName != "theseus") {
          id = "JFJTOJX-S6ITXDO-PJ5CEYI-ZTCAUFJ-7J22EFK-H7VX4AA-KJZ3QLW-XED4WQG";
        };
      };
    };
  };
}
