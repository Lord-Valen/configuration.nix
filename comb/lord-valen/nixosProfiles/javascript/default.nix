{
  inputs,
  cell,
  pkgs,
}:
{
  programs.npm.enable = true;
  environment.systemPackages = with pkgs; [
    nodejs
    nodePackages.pnpm
    yarn
    bun
    deno
  ];
}
