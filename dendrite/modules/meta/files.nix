{ inputs, ... }:
{
  flake-file.inputs.files.url = "github:mightyiam/files";
  imports = [
    inputs.files.flakeModules.default
  ];

  perSystem =
    { config, ... }:
    {
      files.gitToplevel = ../../../.;
      packages.${config.files.writer.exeFilename} = config.files.writer.drv;
    };
}
