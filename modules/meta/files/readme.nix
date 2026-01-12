{ config, ... }:
{
  text.readme = {
    order = [
      "allowedUnfreePackages"
      "hosts"
    ];
  };

  perSystem =
    {
      pkgs,
      ...
    }:
    {
      files.files = [
        {
          path_ = "README.md";
          drv = pkgs.writeText "README.md" config.text.readme;
        }
      ];
    };
}
