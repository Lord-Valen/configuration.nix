{
  flake.modules.hosts.heracles.services.snapper.configs.games_nvme = {
    SUBVOLUME = "/home/lord-valen/Games/nvme";
    QGROUP = "1/5400";
    TIMELINE_CREATE = true;
    TIMELINE_CLEANUP = true;
    EMPTY_PRE_POST_CLEANUP = true;
    TIMELINE_LIMIT_HOURLY = "2-10";
    TIMELINE_LIMIT_DAILY = "0-5";
    TIMELINE_LIMIT_WEEKLY = "0-4";
    TIMELINE_LIMIT_MONTHLY = "0-2";
    TIMELINE_LIMIT_QUARTERLY = "0-1";
    TIMELINE_LIMIT_YEARLY = "0-1";
  };
}
