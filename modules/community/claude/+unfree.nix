{ den, ... }:
{
  den.aspects.claude = {
    includes = [ (den.batteries.unfree [ "claude-code" ]) ];
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          claude-code
        ];
      };
  };
}
