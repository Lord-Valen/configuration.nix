{
  flake.modules.nixos.heracles.services.snapper.configs.games_hdd = {
    SUBVOLUME = "/home/lord-valen/Games/hdd";
    # QGROUP = "1/5400";
    TIMELINE_CREATE = true;
    TIMELINE_CLEANUP = true;
    EMPTY_PRE_POST_CLEANUP = true;
    TIMELINE_LIMIT_HOURLY = "2";
    TIMELINE_LIMIT_DAILY = "0";
    TIMELINE_LIMIT_WEEKLY = "0";
    TIMELINE_LIMIT_MONTHLY = "0";
    TIMELINE_LIMIT_QUARTERLY = "0";
    TIMELINE_LIMIT_YEARLY = "0";
  };
}
