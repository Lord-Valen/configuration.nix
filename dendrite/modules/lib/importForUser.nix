{ lib, ... }:
{
  /**
    Create a nixos module which imports a home-manager module for a given user.

    # Type

    ```
    importForUser :: string -> string -> Module
    ```
  */
  flake.lib.importForUser =
    user: module:
    {
      config,
      ...
    }:
    let
      users = config.home-manager.users;
      modules = config.flake.modules.home-manager;
    in
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
    # Assert first to help keep typos from creeping in.
    lib.mkIf (lib.assertOneOf "module" module modules && user ? users) {
      home-manager.users.${user}.imports = [
        config.flake.modules.home-manager.${module}
      ];
    };
}
