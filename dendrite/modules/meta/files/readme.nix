{ config, ... }:
{
  text.readme = {
    order = [
      "allowedUnfreePackages"
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
          path_ = "dendrite/README.md";
          drv = pkgs.writeText "README.md" config.text.readme;
        }
      ];
    };
}
