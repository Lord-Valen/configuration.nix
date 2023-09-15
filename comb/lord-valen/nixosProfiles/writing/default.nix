{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
in {
  fonts = {
    fontDir.enable = true;
    packages = with nixpkgs; [
      fira
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
