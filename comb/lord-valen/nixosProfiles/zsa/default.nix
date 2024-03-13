{ inputs, cell }:
let
  inherit (inputs) nixpkgs;
in
{
  hardware.keyboard.zsa.enable = true;
  environment.systemPackages = with nixpkgs; [ wally-cli ];
}
