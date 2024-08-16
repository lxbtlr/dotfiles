{
  config,
  lib,
  pkgs,
  ...
}: {
  services.flameshot = {
    enable = true;
    settings.General = {
      showStartupLaunchMessage = false;
      saveLastRegion = true;
      startupLaunch = true;
    };
  };
}
