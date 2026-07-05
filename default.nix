{
  with-inputs ? import ./with-inputs.nix,
  follows ? import ./follows.nix,
  outputs ? import ./outputs.nix,
  ...
}:
with-inputs follows outputs
