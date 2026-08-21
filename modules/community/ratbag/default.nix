{
  den.aspects.ratbag.nixos =
    { pkgs, ... }:
    {
      services.ratbagd.enable = true;
      environment.systemPackages = with pkgs; [
        piper
      ];
    };
}
