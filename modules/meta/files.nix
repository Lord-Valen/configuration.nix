{ inputs, ... }:
{
  imports = [
    (inputs.files + "/flake-module.nix")
  ];

  perSystem =
    { config, ... }:
    {
      files.gitToplevel = ../../.;
      packages.${config.files.writer.exeFilename} = config.files.writer.drv;
    };
}
