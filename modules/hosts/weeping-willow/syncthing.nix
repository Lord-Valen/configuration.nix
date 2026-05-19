{ den, ... }:
{
  den.aspects.weeping-willow = {
    includes = with den.aspects; [ syncthing ];
    provides.sioux.includes = with den.aspects; [ syncthing ];
  };
}
