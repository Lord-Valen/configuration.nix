{
  den.aspects.development.nixos =
    { pkgs, ... }:
    {
      environment.systemPackages = [ pkgs.android-tools ];
    };
}
