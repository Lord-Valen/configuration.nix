{
  inputs,
  cell,
}:
inputs.cells.repo.lib.rakeLeaves ./nixos/modules
