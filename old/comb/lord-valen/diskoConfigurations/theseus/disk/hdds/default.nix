{ inputs, cell }:
{
  device = "/dev/sdb";
  type = "disk";
  content = {
    type = "gpt";
    partitions = inputs.std.inputs.haumea.lib.load { src = ./_partitions; };
  };
}
