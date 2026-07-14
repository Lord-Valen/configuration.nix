let
  self = import ./. { };
  inherit (self.inputs.nixpkgs) lib;
  hostname = lib.trim (lib.readFile /etc/hostname);
in
self.nixosConfigurations.${hostname}
  or (builtins.throw "No NixOS configuration for hostname '${hostname}'")
