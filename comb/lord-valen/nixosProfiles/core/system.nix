{
  inputs,
  cell,
  lib,
  pkgs,
  config,
  ...
}:
{
  activationScripts.diff = {
    supportsDryActivation = true;
    text = ''
      ${lib.getExe pkgs.nvd} \
        --nix-bin-dir ${lib.getBin config.nix.package}/bin \
        diff /run/current-system "$systemConfig"
    '';
  };
}
