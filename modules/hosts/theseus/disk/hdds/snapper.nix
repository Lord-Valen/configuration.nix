{
  flake.modules.hosts.theseus.services.snapper.configs = {
    data = {
      SUBVOLUME = "/data";
      # QGROUP = "1/5400";
      TIMELINE_CREATE = true;
      TIMELINE_CLEANUP = true;
      EMPTY_PRE_POST_CLEANUP = true;
      TIMELINE_LIMIT_HOURLY = "1";
      TIMELINE_LIMIT_DAILY = "1";
      TIMELINE_LIMIT_WEEKLY = "0";
      TIMELINE_LIMIT_MONTHLY = "0";
      TIMELINE_LIMIT_YEARLY = "0";
    };
  };
}
