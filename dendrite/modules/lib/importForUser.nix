{ lib, ... }:
let
  /*
    TODO: Assert that user is defined.
    Currently we check whether the user exists
    - i.e. their module is imported -
    but we want to assert that there is at least a module for that user.
    If there isn't, then there is a typo or it is dead code.

    This means I will have to rewrite my users such that they have their
    own namespace `flake.modules.users` and are an attrset of the different
    module namespaces e.g. `user.nixos` and `user.home-manager`.
  */
  checkUser = user: nixosConfig: nixosConfig.home-manager.users ? user;
in
{
  /**
    Create a nixos module which imports a home-manager module, `module`, for `user`.

    # Type

    ```
    importForUser :: string -> [Module] -> Module
    ```
  */
  flake.lib.importForUser =
    user: module:
    {
      config,
      ...
    }:
    # Assert first to help keep typos from creeping in.
    lib.mkIf (checkUser user config) {
      home-manager.users.${user}.imports = [
        module
      ];
    };

  /**
    Create a nixos module which imports a home-manager module, `module`, for `user`.

    # Type

    ```
    importForUser :: string -> [Module] -> Module
    ```
  */
  flake.lib.importManyForUser =
    user: modules:
    {
      config,
      ...
    }:
    lib.mkIf (checkUser user config) {
      home-manager.users.${user}.imports = modules;
    };
}
