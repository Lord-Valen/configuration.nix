{
  inputs,
  cell,
}:
{
  device = "/dev/disk/by-id/ata-KINGSTON_SA400S37240G_50026B778587C1D7";
  type = "disk";
  content = {
    type = "gpt";
    partitions = inputs.std.inputs.haumea.lib.load { src = ./_partitions; };
  };
}
