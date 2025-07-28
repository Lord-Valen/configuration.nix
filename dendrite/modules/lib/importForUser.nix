{ lib, ... }:
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
    lib.mkIf (config ? home-manager) {
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
    {
      home-manager.users.${user}.imports = lib.optionals (config ? home-manager) modules;
    };
}
