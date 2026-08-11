{
  den,
  ...
}:
{
  den.aspects.japanese = {
    includes = with den.aspects; [ fcitx ];
    nixos = { pkgs, ... }: {
      i18n.inputMethod.fcitx5.addons = with pkgs; [
        fcitx5-mozc-ut
      ];
    };
  };
}
