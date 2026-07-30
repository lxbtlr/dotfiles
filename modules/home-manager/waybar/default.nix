# Waybar, ported from the nixferatu config to niri.
#
# Changes from the original:
#   - added niri/workspaces (the original had no workspace module at all)
#   - network.interface     -> removed (was hardcoded to wlp0s20f3)
#   - systemd.enable        -> false, so the bar is scoped to the niri session
#                              rather than also starting under Plasma
#
# Colors and fonts are NOT set here — stylix.targets.waybar handles those.
# This file only carries layout and spacing.

{ lib, pkgs, ... }:

{
  programs.waybar = {
    enable = true;

    # Launched from niri's spawn-at-startup instead of a user unit. See notes.
    systemd.enable = false;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";

        modules-left = [ "niri/workspaces" ];
        modules-center = [ "niri/window" ];
        modules-right = [ "battery" "network" "pulseaudio" "memory" "clock" ];

        "niri/workspaces" = {
          format = "{icon}";
          format-icons = {
            active = "";
            default = "";
          };
          all-outputs = false;
        };

        "niri/window" = {
          format = "{}";
          max-length = 60;
          separate-outputs = true;
        };

        network = {
          # No interface pin — waybar picks the active one.
          format-wifi = "{icon}";
          format-ethernet = "{ifname}: {ipaddr} {icon}";
          format-disconnected = "{icon}";
          format-icons = [ "󰤯" "󰤟" "󰤢" "󰤥" "󰤨" ];
          format-icons-disconnected = "󰤭";
          tooltip-format-wifi = "{essid} ({signalStrength}%)";
        };

        pulseaudio = {
          format = "{icon}";
          format-bluetooth = "{icon}";
          format-muted = "";
          format-icons.default = [ "" "" "" ];
          scroll-step = 1;
          on-click = "pavucontrol";
          ignored-sinks = [ "Easy Effects Sink" ];
          tooltip-format = "{icon} {volume}%";
        };

        memory = {
          interval = 5;
          format = "{icon}";
          format-icons = [ "○" "◔" "◑" "◕" "●" ];
          tooltip-format = "󰍛 {used:0.1f}G/{total:0.1f}G, {percentage}%";
        };

        clock = {
          format = "  {:%H:%M %a %d %b}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };

        battery = {
          format = "{icon}";
          format-icons = {
            charging = [ "󰢟" "󰂆" "󰢝" "󰢞" "󰂅" ];
            discharging = [ "󰂎" "󰁻" "󰁾" "󰂀" "󰁹" ];
            full = [ "󰁹" ];
          };
          format-alt = "{time} {icon}";
          tooltip-format = "{capacity}%";
          interval = 10;
        };
      };
    };

    # mkAfter matters: `style` is a `lines` option and stylix also writes to it.
    # Without mkAfter, merge order decides whether your rules or stylix's win.
    style = lib.mkAfter ''
      #battery {
        margin: 0 1.5px;
      }

      #memory {
        padding-bottom: 2.5px;
      }

      #clock {
        margin-right: 2.5px;
      }

      #workspaces button {
        padding: 0 6px;
      }

      #window {
        margin: 0 6px;
      }
    '';
  };

  home.packages = with pkgs; [
    pavucontrol # referenced by the pulseaudio on-click above
  ];
}
