{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.waybar = {
    enable = true;
    systemd = {
      enable = false;
      target = "graphical-session.target";
    };
    style = ''
      * {
      border: none;
      border-radius: 10;
        font-family: "JetbrainsMono Nerd Font" ;
      font-size: 15px;
      min-height: 10px;
      }

      window#waybar {
      background: transparent;
      }

      window#waybar.hidden {
      opacity: 0.2;
      }

      #window {
      margin-top: 6px;
      padding-left: 10px;
      padding-right: 10px;
      border-radius: 10px;
      transition: none;
        color: transparent;
      background: transparent;
      }
      #tags {
      margin-top: 6px;
      margin-left: 12px;
      font-size: 4px;
      margin-bottom: 0px;
      border-radius: 10px;
      background: #161320;
      transition: none;
      }

      #tags button {
      transition: none;
      color: #B5E8E0;
      background: transparent;
      font-size: 16px;
      border-radius: 2px;
      }

      #tags button.occupied {
      transition: none;
      color: #F28FAD;
      background: transparent;
      font-size: 4px;
      }

      #tags button.focused {
      color: #ABE9B3;
        border-top: 2px solid #ABE9B3;
        border-bottom: 2px solid #ABE9B3;
      }

      #tags button:hover {
      transition: none;
      box-shadow: inherit;
      text-shadow: inherit;
      color: #FAE3B0;
        border-color: #E8A2AF;
        color: #E8A2AF;
      }

      #tags button.focused:hover {
          color: #E8A2AF;
      }

      #network {
      margin-top: 6px;
      margin-left: 8px;
      padding-left: 10px;
      padding-right: 10px;
      margin-bottom: 0px;
      border-radius: 10px;
      transition: none;
      color: #161320;
      background: #bd93f9;
      }

      #pulseaudio {
      margin-top: 6px;
      margin-left: 8px;
      padding-left: 10px;
      padding-right: 10px;
      margin-bottom: 0px;
      border-radius: 10px;
      transition: none;
      color: #1A1826;
      background: #FAE3B0;
      }

      #battery {
      margin-top: 6px;
      margin-left: 8px;
      padding-left: 10px;
      padding-right: 10px;
      margin-bottom: 0px;
      border-radius: 10px;
      transition: none;
      color: #161320;
      background: #B5E8E0;
      }

      #battery.charging, #battery.plugged {
      color: #161320;
        background-color: #B5E8E0;
      }

      #battery.critical:not(.charging) {
         background-color: #B5E8E0;
         color: #161320;
         animation-name: blink;
         animation-duration: 0.5s;
         animation-timing-function: linear;
         animation-iteration-count: infinite;
         animation-direction: alternate;
      }

      @keyframes blink {
          to {
              background-color: #BF616A;
              color: #B5E8E0;
          }
      }

      #backlight {
      margin-top: 6px;
      margin-left: 8px;
      padding-left: 10px;
      padding-right: 10px;
      margin-bottom: 0px;
      border-radius: 10px;
      transition: none;
      color: #161320;
      background: #F8BD96;
      }
      #clock {
      margin-top: 6px;
      margin-left: 8px;
      padding-left: 10px;
      padding-right: 10px;
      margin-bottom: 0px;
      border-radius: 10px;
      transition: none;
      color: #161320;
      background: #ABE9B3;
      /*background: #1A1826;*/
      }

      #memory {
      margin-top: 6px;
      margin-left: 8px;
      padding-left: 10px;
      margin-bottom: 0px;
      padding-right: 10px;
      border-radius: 10px;
      transition: none;
      color: #161320;
      background: #DDB6F2;
      }
      #cpu {
      margin-top: 6px;
      margin-left: 8px;
      padding-left: 10px;
      margin-bottom: 0px;
      padding-right: 10px;
      border-radius: 10px;
      transition: none;
      color: #161320;
      background: #96CDFB;
      }

      #tray {
      margin-top: 6px;
      margin-left: 8px;
      padding-left: 10px;
      margin-bottom: 0px;
      padding-right: 10px;
      border-radius: 10px;
      transition: none;
      color: #B5E8E0;
      background: #161320;
      }

      #custom-launcher {
      font-size: 24px;
      margin-top: 6px;
      margin-left: 8px;
      padding-left: 10px;
      padding-right: 5px;
      border-radius: 10px;
      transition: none;
        color: #89DCEB;
        background: #161320;
      }

      #custom-power {
      font-size: 20px;
      margin-top: 6px;
      margin-left: 8px;
      margin-right: 8px;
      padding-left: 10px;
      padding-right: 5px;
      margin-bottom: 0px;
      border-radius: 10px;
      transition: none;
      color: #161320;
      background: #F28FAD;
      }

      #custom-wallpaper {
      margin-top: 6px;
      margin-left: 8px;
      padding-left: 10px;
      padding-right: 10px;
      margin-bottom: 0px;
      border-radius: 10px;
      transition: none;
      color: #161320;
      background: #C9CBFF;
      }

      #custom-updates {
      margin-top: 6px;
      margin-left: 8px;
      padding-left: 10px;
      padding-right: 10px;
      margin-bottom: 0px;
      border-radius: 10px;
      transition: none;
      color: #161320;
      background: #E8A2AF;
      }

      #custom-media {
      margin-top: 6px;
      margin-left: 8px;
      padding-left: 10px;
      padding-right: 10px;
      margin-bottom: 0px;
      border-radius: 10px;
      transition: none;
      color: #161320;
      background: #F2CDCD;
      }
    '';

    settings = [
      {
        "layer" = "top";
        "position" = "top";
        modules-left = [
          "custom/launcher"
          "temperature"
          "mpd"
          #"custom/cava-internal"
        ];
        modules-center = [
          "tray"
          "clock"
        ];
        modules-right = [
          "pulseaudio"
          "backlight"
          "memory"
          "cpu"
          "network"
          "custom/powermenu"
        ];
        "custom/launcher" = {
          "format" = " ";
          "on-click" = "pkill rofi || rofi2";
          "on-click-middle" = "exec default_wall";
          "on-click-right" = "exec wallpaper_random";
          "tooltip" = false;
        };
        "custom/cava-internal" = {
          "exec" = "sleep 1s && cava-internal";
          "tooltip" = false;
        };
        "pulseaudio" = {
          "scroll-step" = 1;
          "format" = "{icon} {volume}%";
          "format-muted" = "󰖁 Muted";
          "format-icons" = {
            "default" = ["" "" ""];
          };
          "on-click" = "pamixer -t";
          "tooltip" = false;
        };
        "clock" = {
          "interval" = 1;
          "format" = "{:%I:%M %p  %A %b %d}";
          "tooltip" = true;
          "tooltip-format" = "{=%A; %d %B %Y}\n<tt>{calendar}</tt>";
        };
        "memory" = {
          "interval" = 1;
          "format" = "󰻠 {percentage}%";
          "states" = {
            "warning" = 85;
          };
        };
        "cpu" = {
          "interval" = 1;
          "format" = "󰍛 {usage}%";
        };
        "mpd" = {
          "max-length" = 25;
          "format" = "<span foreground='#bb9af7'></span> {title}";
          "format-paused" = " {title}";
          "format-stopped" = "<span foreground='#bb9af7'></span>";
          "format-disconnected" = "";
          "on-click" = "mpc --quiet toggle";
          "on-click-right" = "mpc update; mpc ls | mpc add";
          "on-click-middle" = "kitty --class='ncmpcpp' ncmpcpp ";
          "on-scroll-up" = "mpc --quiet prev";
          "on-scroll-down" = "mpc --quiet next";
          "smooth-scrolling-threshold" = 5;
          "tooltip-format" = "{title} - {artist} ({elapsedTime:%M:%S}/{totalTime:%H:%M:%S})";
        };
        "network" = {
          "format-disconnected" = "󰯡 Disconnected";
          "format-ethernet" = "󰒢 Connected!";
          "format-linked" = "󰖪 {essid} (No IP)";
          "format-wifi" = "󰖩 {essid}";
          "interval" = 1;
          "tooltip" = false;
        };
        "custom/powermenu" = {
          "format" = "";
          "on-click" = "pkill rofi || ~/.config/rofi/powermenu/type-3/powermenu.sh";
          "tooltip" = false;
        };
        "tray" = {
          "icon-size" = 18;
          "spacing" = 3;
        };
      }
    ];
  };
}