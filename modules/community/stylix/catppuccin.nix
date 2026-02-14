{
  flake.aspects.stylix-catppuccin-mocha.nixos =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      accentUpper = "Green";
      accent = lib.toLower accentUpper;
      flavor = "mocha";
    in
    {
      environment.systemPackages =
        lib.optional config.services.desktopManager.plasma6.enable
        <| pkgs.catppuccin-kde.override {
          flavour = lib.singleton flavor;
          accents = lib.singleton accent;
        };
      stylix = {
        base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-${flavor}.yaml";
        cursor = {
          name = "catppuccin-${flavor}-${accent}-cursors";
          package = pkgs.catppuccin-cursors."${flavor}${accentUpper}";
          size = 28;
        };
        icons = {
          enable = true;
          package = pkgs.catppuccin-papirus-folders.override {
            inherit accent flavor;
          };
          light = "Papirus-Light";
          dark = "Papirus-Dark";
        };
      };
    };
}
