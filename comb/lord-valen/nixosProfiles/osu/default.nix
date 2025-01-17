{
  pkgs,
}:
{
  imports = [ cell.nixosProfiles.tablet ];
  environment.systemPackages = with pkgs; [ osu-lazer-bin ];
}
