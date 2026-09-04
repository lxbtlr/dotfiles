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
    enable = false;

    # Launched from niri's spawn-at-startup instead of a user unit. See notes.
    systemd.enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 10;

        modules-left = [ "niri/window" ];
        modules-center = [ "niri/workspaces" ];
        modules-right = [ "battery" "network" "wireplumber" "memory" "clock" ];

        "niri/workspaces" = {
          format = "{icon}";
          format-icons = {
            #active = "*";
            #default = "-";
          };
          all-outputs = true;
        };

        "niri/window" = {
          format = "{app_id}";
          max-length = 60;
          separate-outputs = true;
          rewrite = {
            "com.mitchellh.ghostty" = "Ghostty";
            "org.mozilla.firefox" = "Firefox";
            "org.telegram.desktop" = "Telegram";
            "zen-beta" = "Zen";
            "slack" = "Slack";
            };
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

        wireplumber = {
          format = "{icon}";
          format-bluetooth = "{icon}";
          #format-muted = "󰝟";
          padding = [5 5];
          format-icons = ["𝄽" "♪" "♫" ]; 
          scroll-step = 1;
          tooltip-format = "{icon} {volume}%";
          on-click = "pavucontrol";
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
/* Colors (dracula) */
@define-color foreground	#f8f8f2;
@define-color background	rgba(40, 42, 54, 0.5);
@define-color orange	#ffb86c;
@define-color gray	#44475a;
@define-color black #21222c;
@define-color red	#ff5555;
@define-color green	#50fa7b;
@define-color yellow	#f1fa8c;
@define-color cyan	#8be9fd;
@define-color blue	#6272a4;
@define-color purple	#bd93f9;
@define-color pink	#ff79c6;
@define-color white #ffffff;
@define-color brred #ff6e6e;
@define-color brgreen #69ff94;
@define-color bryellow #ffffa5;
@define-color brcyan #a4ffff;
@define-color brblue #6272a4;
@define-color brpurple #d6acff;
@define-color brpink #ff92df;

@define-color arch_blue #89b4fa;

@define-color workspace_background	@background;
@define-color workspace_button	@foreground;
@define-color workspace_active	@black;
@define-color workspace_active_background	@white;
@define-color workspace_urgent	@white;
@define-color workspace_urgent_background	@brred;
@define-color workspace_hover	@black;
@define-color workspace_hover_background	@pink;
@define-color critical	@red;
@define-color warning	@yellow;


@keyframes blink {
    to {
        background-color: @white;
        color: @black;
    }
}

* {
    border: none;
    border-radius: 0;
    font-family: "monospace";
    font-weight: bold;
    font-size: 14px;
    min-height: 0;
}
.modules-right > widget > * {
margin-top: -10px;
    font-size: 16px;
margin-bottom: -10px;
}
#clock {
    font-size: 14px;
}
#network {
    font-family: "emoji";
    margin-top: -10px;
    margin-bottom: -20px;
}


window#waybar {
    background: @black; 
    color: @foreground;
}

#workspaces {
    background: @workspace_background;
    opacity: 1;
    transition: none;
    padding: 5px 5px;
    border-radius: 5px;
}

/* ── niri/workspaces button states ──────────────────────────────────────
   .empty    = exists but no windows (named workspaces never disappear)
   .active   = visible on this output but not keyboard-focused
   .focused  = the workspace currently receiving input
   .urgent   = has a window requesting attention
   ───────────────────────────────────────────────────────────────────── */

#workspaces button,
#workspaces button.empty {
    background: transparent;
    color: @blue;
    padding: 0 6px;
    min-width: 18px;
    transition: none;
}

#workspaces button.active {
    background: transparent;
    color: @purple;
    border-bottom: 2px solid @purple;
    border-radius: 5px 5px 0 0;
}

#workspaces button.focused {
    background: @workspace_active_background;
    color: @workspace_active;
    border-radius: 5px;
    border-bottom: 2px solid @pink;
}

#workspaces button.urgent {
    background: @workspace_urgent_background;
    color: @workspace_urgent;
    border-radius: 5px;
    animation-name: blink;
    animation-duration: 0.5s;
    animation-timing-function: linear;
    animation-iteration-count: infinite;
    animation-direction: alternate;
}

#workspaces button:hover {
    background: @workspace_hover_background;
    color: @workspace_hover;
    border-radius: 5px;
}

#workspaces button:not(.current_output) {
    opacity: 0.5;
}

#taskbar {
    background: @background;
    border-radius: 5px;
    margin: 5px 10px 5px 50px;
}

tooltip {
    background: @background;
    opacity: 0.95;
    border-radius: 10px;
    border-width: 2px;
    border-style: solid;
    border-color: @purple;
}

tooltip label {
    color: @foreground;
}

#custom-fuzzel,
#custom-lock_screen,
#custom-power,
#custom-weather,
#custom-khorshididate,
#cpu,
#disk,
#custom-updates,
#memory,
#clock,
#custom-clock,
#battery,
#pulseaudio,
#network,
#tray,
#temperature,
#backlight,
#language {
    background: @background;
    opacity: 1;
    padding: 0px 5px;
    margin: 2px 0px 2px 0px;
}

#disk.critical,
#temperature.critical {
    background-color: @critical;
}

#disk.warning,
#temperature.warning {
    background-color: @warning;
}

#battery {
    color: @green;
    border-radius: 5px 0px 0px 5px;
}

#battery.discharging {
    color: @foreground;
}

#battery.warning:not(.charging) {
    background: @warning;
    animation-name: blink;
    animation-duration: 0.5s;
    animation-timing-function: linear;
    animation-iteration-count: infinite;
    animation-direction: alternate;
}

#battery.critical:not(.charging) {
    background-color: @critical;
    animation-name: blink;
    animation-duration: 0.5s;
    animation-timing-function: linear;
    animation-iteration-count: infinite;
    animation-direction: alternate;
}

#custom-fuzzel {
    color: @arch_blue;
    border-radius: 5px 0px 0px 5px;
}

#custom-power {
    color: @red;
    border-radius: 0px 5px 5px 0px;
}

#clock,
#custom-clock {
    border-radius: 0px 5px 5px 0px;
}

#tray {
    background: @background;
    border-radius: 5px;
    margin: 5px 50px 5px 10px;
}

#wireplumber {
    background: @background;
}

#wireplumber.source {
    background: @background;
}

'';
#      #battery {
#        margin: 0 1.5px;
#      }
#
#      #memory {
#        padding-bottom: 2.5px;
#      }
#
#      #clock {
#        margin-right: 2.5px;
#      }
#
#      #workspaces button {
#        padding: 0 6px;
#        color: @base0D
#      }
#
#      #window {
#        margin: 0 6px;
#      }
#    '';
  };

  home.packages = with pkgs; [
    pavucontrol # referenced by the pulseaudio on-click above
  ];

  systemd.user.services.waybar.Unit.ConditionEnvironment =
      lib.mkForce [ "WAYLAND_DISPLAY" "XDG_CURRENT_DESKTOP=niri" ];
}
