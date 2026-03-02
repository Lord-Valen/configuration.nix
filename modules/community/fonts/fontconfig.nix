{
  flake.modules.homeManager.fonts =
    { pkgs, ... }:
    {
      fonts.fontconfig.enable = true;
      fonts.fontconfig.defaultFonts =

        {
          sansSerif = [
            "Iosevka Aile"
            "Sarasa Gothic JP"
          ];
          serif = [
            "Iosevka Etoile"
            "Sarasa Gothic JP"
          ];
          monospace = [
            "Iosevka Term SS05"
            "Sarasa Term JP"
          ];
        };
      home.packages =
        let
          iosevka-aile = pkgs.iosevka-bin.override { variant = "Aile"; };
          iosevka-etoile = pkgs.iosevka-bin.override { variant = "Etoile"; };
          iosevka-ss05 = pkgs.iosevka-bin.override { variant = "SS05"; };
        in
        with pkgs;
        [
          iosevka-aile
          iosevka-etoile
          iosevka-ss05
          pkgs.sarasa-gothic
        ];
    };
}
