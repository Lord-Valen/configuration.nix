{ inputs, ... }:
{
  flake-file.inputs.files = {
    url = "github:mightyiam/files";
    flake = false;
  };
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
