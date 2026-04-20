{ ... }:
{
  den.aspects.android.nixos =
    { pkgs, ... }:
    {
      environment.systemPackages = [ pkgs.android-tools ];
    };
}
