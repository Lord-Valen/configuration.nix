{
  lib,
  den,
  inputs,
  ...
}:
{
  imports = [
    (inputs.den.flakeModule or { })
    (inputs.elcoco.flakeModules.den or { })
  ];

  den.hosts.x86_64-linux = {
    autolycus.users = {
      lord-valen = { };
      root = { };
    };
    heracles.users = {
      lord-valen = { };
      root = { };
    };
    theseus.users = {
      lord-valen = { };
      nixos = {
        classes = [ ];
      };
    };
    weeping-willow.users = {
      lord-valen = { };
      sioux = { };
    };
  };

  den.schema.host.includes =
    with den.aspects;
    [
      base
      home-manager
    ]
    ++ [ den.batteries.hostname ];
  den.schema.user.classes = lib.mkDefault [ "homeManager" ];
  den.schema.user.includes = [ den.batteries.mutual-provider ];
}
