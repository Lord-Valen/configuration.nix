{ config, ... }:
{
  text.readme = {
    order = [
      "hosts"
      "closure-checks"
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
