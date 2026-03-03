{
  nixpkgs.allowedUnfreePackages = [
    "claude-code"
  ];
  flake.aspects.claude.nixos =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        claude-code
      ];
    };
}
