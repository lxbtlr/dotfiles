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

          plugins.enabled = [
            "noctalia/wallhaven"
          ];

          idle.behavior = {
            lock = {
              timeout = 300;
              action = "lock";
              enabled = false;
            };

            "screen-off" = {
              timeout = 600;
              action = "screen_off";
              enabled = true;
            };

            suspend = {
              timeout = 600;
              action = "suspend";
              enabled = false;
            };
          };


          shell.session.actions = [
            {
              action = "logout";
              enabled = true;
            }
            {
              action = "suspend";
              enabled = true;
            }
            {
              action = "reboot";
              enabled = true;
            }
            {
              action = "shutdown";
              enabled = true;
              variant = "destructive";
            }
          ];

      enable_overdrive = false;
      shell = {
        font_family = "JetBrains Mono Medium Nerd Font Complete";
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
        templates = {
          enable_builtin_templates = true;
          builtin_ids = ["niri"];
        };

        mode = "dark";
        source = "community_palette";
        #builtin = "Dracula";
        community_palette = "Oxocarbon"; 
      };


      wallpaper = {
        
        enabled = true; 
        fill_mode = "fill";
        directory = "~/Pictures/wallpapers/ascii";
        
        transition = [ "fade" "wipe" "disc" "stripes" "zoom" "honeycomb" ];
          transition_duration = 1500;
          transition_on_startup = true;
        
        automation = {
            enabled = true;
            interval_seconds = 1800;
            order = "random";        # or "alphabetical"
            recursive = true;
          };




        };

      # swaylock is bound to Mod+Alt+L and wired into logind via swayidle.
      #lockscreen.enabled = true;

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


      notification.enable_daemon = true;

      system.monitor.enabled = true;
    };
  };

  # Scope to the niri session only. Without this the shell also starts under
  # Plasma, where it would fight kwin's own bar, notifications and OSD.
  systemd.user.services.noctalia.Unit.ConditionEnvironment =
    lib.mkForce "XDG_CURRENT_DESKTOP=niri";
}
