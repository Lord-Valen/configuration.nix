{
  inputs,
  cell,
  pkgs,
}:
{
  imports = with cell.nixosProfiles; [ avahi ];
  hardware.sane.enable = true;
  programs.system-config-printer.enable = true;
  environment.systemPackages = with pkgs; [ simple-scan ];

  services = {
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
