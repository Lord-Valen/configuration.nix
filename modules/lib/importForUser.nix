{ ... }:
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
      ...
    }:
    {
      home-manager.users.${user}.imports = [
        module
      ];
    };

  /**
    Create a nixos module which imports a list of home-manager modules, `modules`, for `user`.

    # Type

    ```
    importManyForUser :: string -> [Module] -> Module
    ```
  */
  flake.lib.importManyForUser =
    user: modules:
    {
      ...
    }:
    {
      home-manager.users.${user}.imports = modules;
    };
}
