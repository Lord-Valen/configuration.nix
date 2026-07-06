let
  outputs = import ./. { };
  hostname = outputs.inputs.nixpkgs.lib.trim (builtins.readFile /etc/hostname);
in
outputs.nixosConfigurations.${hostname}
  or (builtins.throw "No NixOS configuration for hostname '${hostname}'")
