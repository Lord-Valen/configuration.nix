{
  inputs,
  cell,
}:
inputs.cells._repo.lib.rakeLeaves ./nixos/modules
