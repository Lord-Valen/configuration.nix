# TODO: This should be a suite.
{
  inputs,
  cell,
  pkgs,
}:
{
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      (iosevka-bin.override { variant = "Aile"; })
      (iosevka-bin.override { variant = "Etoile"; })
      liberation_ttf
    ];
  };
  environment.systemPackages = with pkgs; [
    zotero
    biber
    onlyoffice-bin
  ];
}
