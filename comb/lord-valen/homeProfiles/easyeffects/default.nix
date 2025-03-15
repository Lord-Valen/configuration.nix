{pkgs,}:{
  services.easyeffects.enable = true;
  home.packages = [
    pkgs.easyeffects
  ];
}
