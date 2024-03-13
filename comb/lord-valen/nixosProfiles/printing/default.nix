{ inputs, cell }:
let
  inherit (inputs) nixpkgs;
in
{
  hardware.sane.enable = true;
  programs.system-config-printer.enable = true;
  environment.systemPackages = with nixpkgs; [ simple-scan ];

  services = {
    avahi = {
      enable = true;
      nssmdns = true;
    };

    printing = {
      enable = true;
      drivers = with nixpkgs; [
        gutenprint
        gutenprintBin
        foomatic-filters
        brlaser
      ];
    };

    saned.enable = true;
  };
}
