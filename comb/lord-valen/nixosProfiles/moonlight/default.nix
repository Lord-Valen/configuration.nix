{
  inputs,
  cell,
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [ moonlight-qt ];
  services.avahi = {
    enable = true;
    publish = {
      enable = true;
      userServices = true;
    };
  };
}
