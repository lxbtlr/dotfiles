{ config, lib, ... }:

# Full reference: https://docs.noctalia.dev/v5
{
  programs.noctalia = {
    enable = true;

    # Started by systemd rather than niri's spawn-at-startup, so it restarts
    # on failure. See the ConditionEnvironment at the bottom for session
    # scoping — without it this would also start under Plasma.
    systemd.enable = true;

    settings = {
      shell = {
        font_family = "Maple Mono";
        settings_show_advanced = true;
        telemetry_enabled = false;

        # niri-specific: type-to-launch from the overview (Mod+O).
        niri_overview_type_to_launch_enabled = true;

        # niri's NixOS module already runs a polkit agent. Leave this off or
        # you get two agents racing for the same prompts.
        polkit_agent = false;

        # vicinae already handles clipboard history.
        clipboard_enabled = false;
      };

      theme = {
        mode = "dark";
        source = "builtin";
        builtin = "Dracula"; # matches the waybar CSS you imported
      };

      # ── Disabled: something else already does this ────────────────────────

      # swaybg owns the wallpaper (see spawn-at-startup in niri-settings.nix).
      wallpaper.enabled = true;

      # swaylock is bound to Mod+Alt+L and wired into logind via swayidle.
      lockscreen.enabled = false;

      # ── Bar ───────────────────────────────────────────────────────────────
      #
      # Left configured but you must pick ONE bar. Two layer-shell bars with
      # reserve_space = true both claim screen edge space and you get a double
      # gap at the top. Either:
      #   (a) keep waybar  -> set programs.waybar.enable = false is NOT needed,
      #       instead delete this whole bar.main block, or
      #   (b) keep noctalia -> set programs.waybar.enable = false in waybar.nix
      #
      # Starting point mirroring your current waybar layout:
      bar.main = {
        position = "top";
        thickness = 34;
        radius = 12;
        margin_edge = 10;
        reserve_space = true;

        start = [ "workspaces" ];
        center = [ "clock" ];
        end = [
          "tray"
          "notifications"
          "network"
          "bluetooth"
          "volume"
          "brightness"
          "battery"
          "control-center"
          "session"
        ];
      };

      # Launcher: vicinae is bound to Mod+D, so noctalia's is left out of the
      # bar above. Its providers stay at defaults and cost nothing unused.

      notification.enable_daemon = true;

      system.monitor.enabled = true;
    };
  };

  # Scope to the niri session only. Without this the shell also starts under
  # Plasma, where it would fight kwin's own bar, notifications and OSD.
  systemd.user.services.noctalia.Unit.ConditionEnvironment =
    lib.mkForce "XDG_CURRENT_DESKTOP=niri";
}
