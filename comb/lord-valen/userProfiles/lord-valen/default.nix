{
  inputs,
  cell,
  config,
}: let
  inherit (inputs) nixpkgs;
in {
  users.users.lord-valen = {
    initialHashedPassword = "$6$nVSlPb7ImRaYAkid$xMyn6KfAw1r9KqOZrZB8ldfk5zNZSU7U/QKST.M218dkzxGbXLf/7RzQflpH.csU6vubGG21QqRRqv8yKrsdb0";
    isNormalUser = true;
    createHome = true;
    extraGroups = ["adbusers" "libvirtd" "networkmanager" "wheel" "config.services.kubo.group"];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJlTDo77mX1eDjo5o44C9pvIt+8nOptLVJQoGr1/Ilgl" #cardno:25_313_700
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICpUIUwaDNzvZJpkhhsK/yN1DaMCqhpmDFILhXG1kfOr" #cardno:20_624_908
    ];
    shell = nixpkgs.nushell;
  };
}
