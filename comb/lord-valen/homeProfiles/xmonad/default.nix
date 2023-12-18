{
  inputs,
  cell,
}: let
  inherit (cell.homeProfiles) picom;
in {
  _imports = [picom];
  xsession = {
    enable = true;
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      config = ./_xmonad.d/xmonad.hs;
    };
  };
}
