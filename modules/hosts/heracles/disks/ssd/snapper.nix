{
  flake.modules.host.heracles.services.snapper.configs.home = {
    SUBVOLUME = "/home";
    # QGROUP = "1/5400";
    TIMELINE_CREATE = true;
    TIMELINE_CLEANUP = true;
    EMPTY_PRE_POST_CLEANUP = true;
    TIMELINE_LIMIT_HOURLY = "2";
    TIMELINE_LIMIT_DAILY = "1";
    TIMELINE_LIMIT_WEEKLY = "1";
    TIMELINE_LIMIT_MONTHLY = "0";
    TIMELINE_LIMIT_QUARTERLY = "0";
    TIMELINE_LIMIT_YEARLY = "0";
  };
}
