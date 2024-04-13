{
  inputs,
  cell,
  pkgs,
}:
{
  hardware.sane.enable = true;
  programs.system-config-printer.enable = true;
  environment.systemPackages = with pkgs; [ simple-scan ];

  services = {
    avahi = {
      enable = true;
      nssmdns4 = true;
    };

    printing = {
      enable = true;
      drivers = with pkgs; [
        gutenprint
        gutenprintBin
        foomatic-filters
        brlaser
      ];
    };

    saned.enable = true;
  };
}
