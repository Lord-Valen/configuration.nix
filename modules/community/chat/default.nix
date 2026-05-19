{ den, ... }:
{
  den.aspects.chat = {
    includes = with den.aspects; [
      discord
      matrix
    ];
  };
}
