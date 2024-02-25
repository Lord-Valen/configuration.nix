{ inputs, cell }:
let
  inherit (inputs) nixpkgs;
  inherit (cell) pkgs-unstable;
in
{
  services.openssh.enable = true;

  users.users.root = {
    initialHashedPassword = "$6$rZhNhLxPNJx.lRBn$lXAcMr7CdFgjRcN4ZMlEai2QYWMoawm6pMKrd9oFHXgWks9KBkP3p7Afj/Djj1LnCDyXbLNT5IfVNjDEUzk1p0";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJlTDo77mX1eDjo5o44C9pvIt+8nOptLVJQoGr1/Ilgl" # cardno:25_313_700
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICpUIUwaDNzvZJpkhhsK/yN1DaMCqhpmDFILhXG1kfOr" # cardno:20_624_908
    ];
    # shell = nixpkgs.nushell;
    shell = pkgs-unstable.nushell;
  };
}
