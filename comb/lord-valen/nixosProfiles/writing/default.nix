{
  inputs,
  cell,
  pkgs,
}:
{
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      (iosevka-bin.override { variant = "aile"; })
      (iosevka-bin.override { variant = "etoile"; })
      liberation_ttf
    ];
  };

  environment.systemPackages = with pkgs; [
    zotero
    texlive.combined.scheme-full
    biber
    onlyoffice-bin
  ];
}
