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
        onlyoffice-bin
        typst
      ];
    };

  flake.modules.nixos.fonts = {
    fonts.fontDir.enable = true;
  };
}
