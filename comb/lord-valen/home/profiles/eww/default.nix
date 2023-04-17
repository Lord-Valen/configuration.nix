{pkgs, ...}: {
  home.packages = with pkgs; [
    nushell
    socat
  ];
  programs.eww = {
    enable = true;
    configDir = ./eww.d;
  };
}
