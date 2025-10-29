{ inputs, cell }:
{
  device = "/dev/nvme0n1";
  type = "disk";
  content = {
    type = "gpt";
    partitions = inputs.std.inputs.haumea.lib.load { src = ./_partitions; };
  };
}
