{ den, ... }: {
  den.aspects.heracles = {
    includes = with den.aspects; [ opencl ];
  };
}
