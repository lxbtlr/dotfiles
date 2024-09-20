{
  config,
  lib,
  pkgs,
  ...
}: {
  services.flameshot = {
    enable = true;
    settings.General = {
      savePath = "/home/lxbtlr/Pictures/";
      showStartupLaunchMessage = false;
      saveLastRegion = true;
      startupLaunch = true;
    };
  };
}
