{
  den.aspects.development.nixos = {
    programs.npm.enable = true;
  };
  den.aspects.development.homeManager =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        nodejs
        nodePackages.pnpm
        yarn
        bun
        deno
      ];
    };
}
