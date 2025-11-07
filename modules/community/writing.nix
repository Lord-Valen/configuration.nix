{
  flake.modules.nixos.writing =
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

  flake.modules.nixos.fonts = {
    fonts.fontDir.enable = true;
  };
}
