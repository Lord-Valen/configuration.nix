{ inputs, cell }:
{
  services.syncthing = {
    enable = true;
    guiAddress = "127.0.0.1:8385";
  };
}
