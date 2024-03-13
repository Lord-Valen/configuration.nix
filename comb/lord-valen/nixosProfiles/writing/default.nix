{ inputs, cell }:
let
  inherit (inputs) nixpkgs;
in
{
  fonts = {
    fontDir.enable = true;
    packages = with nixpkgs; [
      (iosevka-bin.override { variant = "aile"; })
      (iosevka-bin.override { variant = "etoile"; })
      liberation_ttf
    ];
  };

  environment.systemPackages = with nixpkgs; [
    zotero
    texlive.combined.scheme-full
    biber
    onlyoffice-bin
  ];
}
