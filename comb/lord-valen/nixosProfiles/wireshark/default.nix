{
  programs.wireshark = {
    enable = true;
    usbmon.enable = true;
  };
  environment.systemPackages = with pkgs; [
    wireshark
  ];
}
