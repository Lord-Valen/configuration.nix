{ config, ... }:
{
  text.readme = {
    order = [
      "hosts"
      "closure-checks"
    ];
  };

  perSystem =
    { ... }:
    {
      files.file."README.md".text = config.text.readme;
    };
}
