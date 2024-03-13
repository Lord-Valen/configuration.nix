{ inputs, cell }:
let
  inherit (inputs) nixpkgs;
in
{
  programs.npm.enable = true;
  environment.systemPackages = with nixpkgs; [
    nodejs
    nodePackages.pnpm
    yarn
    bun
    deno
  ];
}
