{pkgs, ...}: {
  programs.vicinae = {
    enable = true;
    package = pkgs.vicinae; # HM's module asserts non-null when systemd.enable is on
    useLayerShell = true;
    systemd.enable = true;
    #systemd.target = "niri.service";

    settings = {
      close_on_focus_loss = true;
      pop_to_root_on_close = true;
      font.normal = {
        family = "Maple Nerd Font";
        size = 12;
      };
      launcher_window.opacity = 0.98;

      providers.files.preferences = {
        autoIndexing = true;
        indexingPaths = [
          "/home/lxbtlr/dotfiles"
          "/home/lxbtlr/projects"
          "/home/lxbtlr/Zotero/Storage"
        ];
        excludedIndexingPaths = [
          "/home/lxbtlr/projects/node_modules"
          "/home/lxbtlr/.cache"
          "/home/lxbtlr/Downloads"
        ];
      };
    };
  };
  systemd.user.services.vicinae.Unit.ConditionEnvironment = "XDG_CURRENT_DESKTOP=niri";
}
