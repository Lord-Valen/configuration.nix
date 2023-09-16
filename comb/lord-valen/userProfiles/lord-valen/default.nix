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
    shell = nixpkgs.nushell;
  };
}
