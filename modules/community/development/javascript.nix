{
  flake.modules.nixos.development = {
    programs.npm.enable = true;
  };
  flake.modules.homeManager.development =
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
