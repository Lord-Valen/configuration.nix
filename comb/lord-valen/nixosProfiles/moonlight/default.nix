{
  inputs,
  cell,
  pkgs,
}:
{
  # TODO: figure out whether it was sunshine or moonlight that required avahi
  imports = with cell.nixosProfiles; [ avahi ];
  environment.systemPackages = with pkgs; [ moonlight-qt ];
}
