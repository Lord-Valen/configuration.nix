{
  inputs,
  cell,
  pkgs,
}:
{
  environment.systemPackages = with pkgs; [ sunshine ];
  # TODO: figure out whether it was sunshine or moonlight that required avahi
  services.avahi = {
    enable = true;
    publish = {
      enable = true;
      userServices = true;
    };
  };
  networking.firewall = {
    allowedTCPPorts = [
      47984 # sunshine https
      47989 # sunshine http
      47990 # sunshine webui
      48010 # sunshine rtsp
    ];
    allowedUDPPorts = [
      47998 # sunshine video
      47999 # sunshine control
      48000 # sunshine audio
      48002 # sunshine mic
    ];
  };
}
