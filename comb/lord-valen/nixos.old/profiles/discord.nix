{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    webcord
  ];
}
