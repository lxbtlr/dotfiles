{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.flameshot = {
    enable = true;
    settings = {
      settings.General = {
        showStartupLaunchMessage = false;
        saveLastRegion = true;
        startupLaunch = true;
      };
    };
  };
}
