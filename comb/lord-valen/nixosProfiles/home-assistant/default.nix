{ lib }:
{
  services.home-assistant = {
    enable = true;
    config = lib.mkDefault null;
  };
}
