{ pkgs, lib }:
{
  home.packages = with pkgs; [
    (opentrack.overrideAttrs (
      finalAttrs: previousAttrs: {
        buildInputs = previousAttrs.buildInputs ++ [ onnxruntime ];
      }
    ))
  ];
}
