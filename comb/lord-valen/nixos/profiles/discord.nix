{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    webcord
    discord
    betterdiscordctl
  ];
}
