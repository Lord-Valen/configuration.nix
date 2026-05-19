{
  den.aspects.writing.nixos =
    { pkgs, ... }:
    {
      fonts.packages = with pkgs; [
        (iosevka-bin.override { variant = "Aile"; })
        (iosevka-bin.override { variant = "Etoile"; })
        liberation_ttf
      ];

      environment.systemPackages = with pkgs; [
        zotero
        biber
        libreoffice-fresh
        typst
      ];
    };

  den.aspects.fonts.nixos = {
    fonts.fontDir.enable = true;
  };
}
