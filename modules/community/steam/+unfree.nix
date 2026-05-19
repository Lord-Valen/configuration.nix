{ den, ... }:
{
  den.aspects.steam.includes = [
    (den.batteries.unfree [
      "steam"
      "steam-unwrapped"
    ])
  ];
}
