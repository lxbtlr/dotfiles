{ config,lib, pkgs, ... }:

{
  imports = [ 
    ../vicinae
    ../waybar
    ../stylix
    ];

  programs.niri.settings = {

    ############################################################
    # Top-level flags
    ############################################################

    # kdl: prefer-no-csd
    prefer-no-csd = true;

    # kdl: screenshot-path "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png"
    # Only applies to niri's built-in capture (Alt+Print below); the grim binds
    # write their own paths.
    screenshot-path = "~/Pictures/Screenshots/Screenshot_%Y-%m-%d %H-%M-%S.png";


    ############################################################
    # switch-events
    ############################################################

    # this is unsafe lmao
    
    # switch-events = {
    #    lid-close.action.spawn = [ "niri" "msg" "output" "eDP-1" "off" ];
    #    lid-open.action.spawn = [ "niri" "msg" "output" "eDP-1" "on" ];
    # };





    ############################################################
    # Input
    ############################################################

    input = {
      # kdl: input { keyboard { repeat-delay 200; repeat-rate 35 } }
      keyboard = {
        repeat-delay = 200;
        repeat-rate = 100;
        xkb.layout = "us";
      };

      # kdl: focus-follows-mouse max-scroll-amount="0%"
      focus-follows-mouse = {
        enable = true;
        max-scroll-amount = "0%";
      };

      # The tutorial leaves these commented out; adjust to taste.
      touchpad = {
        tap = true;
        natural-scroll = false;
        dwt = true;
      };

      mouse.natural-scroll = false;
    };

    ############################################################
    # Layout
    ############################################################

    # kdl:
    #   layout {
    #       gaps 5
    #       focus-ring { width 1.5; active-color "#7fc8ff"; inactive-color "#505050" }
    #       border { off }
    #   }
    #
    # Note the rename: KDL's `active-color` / `inactive-color` become `active` /
    # `inactive`, each a <decoration> — an attrset tagged `color` or `gradient`.
    layout = {
      gaps = 5;

      # The tutorial hardcodes #7fc8ff / #505050. Pulled from the stylix palette
      # instead so the ring tracks the scheme in ./stylix.nix.
      #
      # This has to be explicit: stylix.targets.niri sets border on and
      # focus-ring OFF, both with mkDefault. Since the tutorial's look is the
      # inverse, we override both here — otherwise stylix silently flips it.
      focus-ring = {
        enable = true;
        width = 1.5;
        active.color = config.lib.stylix.colors.withHashtag.base0D;
        inactive.color = config.lib.stylix.colors.withHashtag.base03;
      };

      # kdl: border { off }
      border.enable = false;
    };

    ############################################################
    # Startup
    ############################################################

    # noctalia-shell is dropped, so wallpaper handling falls back to swaybg.
    # kdl: spawn-sh-at-startup "swaybg -i ~/walls/wall1.png"
    spawn-at-startup = [
      { argv = [ "swaybg" "-i" "${config.stylix.image}" "-m" "fill" ]; }
      { argv = [ "xwayland-satellite" ]; }

      # waybar runs here rather than as a user unit, which scopes it to niri.
      # reset-failed first: waybar trips systemd's default start limit easily,
      # and a latched failure persists across logins.
      #{ sh = "systemctl --user reset-failed waybar.service 2>/dev/null; waybar"; }
    ];

    ############################################################
    # Window rules
    ############################################################

    window-rules = [
      # kdl: window-rule { geometry-corner-radius 4; clip-to-geometry true }
      #
      # No shorthand here: all four corners are required, and the type is
      # strictly float, so `4` fails to evaluate — it must be `4.0`.



      {
        geometry-corner-radius = {
          top-left = 4.0;
          top-right = 4.0;
          bottom-right = 4.0;
          bottom-left = 4.0;
        };
        clip-to-geometry = true;
      }
      {
      matches = [
        { app-id = "^harmonoid$"; }
        { app-id = "^elisa$"; }
        { app-id = "^telegram$"; }
        { app-id = "^slack$"; }
      ];
      open-on-workspace = "media";

      }

      # kdl: window-rule { match title="Firefox"; open-on-workspace "c"; open-maximized true }
      # Requires the named workspace "c" below to be uncommented first.
      # {
      #   matches = [ { title = "Firefox"; } ];
      #   open-on-workspace = "c";
      #   open-maximized = true;
      # }
    ];

    ############################################################
    # Named workspaces (optional)
    ############################################################
  
    workspaces = {
       "1-media" = { name = "media"; }; 
    };
    # kdl: workspace "a" { } etc.
    #
    # Left commented because named workspaces are created first and occupy the
    # lowest indices, which shifts what Mod+1/2/3 land on.
    #
    # workspaces = {
    #   "a" = { };
    #   "b" = { };
    #   "c" = { };
    # };

    ############################################################
    # Binds
    ############################################################

    binds =
      {

        # vertical wheel — workspaces
        "Mod+WheelScrollDown" = {
          cooldown-ms = 150;
          action.focus-workspace-down = { };
        };
        "Mod+WheelScrollUp" = {
          cooldown-ms = 150;
          action.focus-workspace-up = { };
        };
        
        # horizontal wheel — columns (windows) left/right
        "Mod+WheelScrollRight".action.focus-column-right = { };
        "Mod+WheelScrollLeft".action.focus-column-left = { };

          "XF86MonBrightnessUp" = {
            allow-when-locked = true;
            action.spawn = [ "brightnessctl" "--class=backlight" "set" "+5%" ];
          };
          "XF86MonBrightnessDown" = {
            allow-when-locked = true;
            action.spawn = [ "brightnessctl" "--class=backlight" "set" "5%-" ];
          };



        ##### Applications #####
        "Mod+M".action.focus-workspace = "music";
        "Mod+Shift+M".action.move-column-to-workspace = "music";
        # kdl: Mod+Return hotkey-overlay-title="Open a Terminal: alacritty" { spawn "alacritty"; }
        "Mod+Return" = {
          hotkey-overlay.title = "Open a Terminal: ghostty";
          action.spawn = "ghostty";
        };

        # kdl: Mod+D hotkey-overlay-title="Run an Application: fuzzel" { spawn "fuzzel"; }
        # vicinae is a client/server app: this toggles the running daemon.
        "XF86Tools" = {
          hotkey-overlay.title = "Run an Application: vicinae";
          action.spawn = [ "vicinae" "toggle" ];
        };

        "F13" = {
          hotkey-overlay.title = "Run an Application: vicinae";
          action.spawn = [ "vicinae" "toggle" ];
        };

        ##### Session #####

        "Mod+Q".action.close-window = { };
        "Mod+Shift+E".action.quit = { };
        "Mod+Shift+Slash".action.show-hotkey-overlay = { };
        "Mod+O".action.toggle-overview = { };

        ##### Focus (vim keys + arrows) #####

        "Mod+H".action.focus-column-left = { };
        "Mod+J".action.focus-window-down = { };
        "Mod+K".action.focus-window-up = { };
        "Mod+L".action.focus-column-right = { };

        "Mod+Left".action.focus-column-left = { };
        "Mod+Down".action.focus-window-down = { };
        "Mod+Up".action.focus-window-up = { };
        "Mod+Right".action.focus-column-right = { };

        ##### Movement #####

        "Mod+Ctrl+H".action.move-column-left = { };
        "Mod+Ctrl+J".action.move-window-down = { };
        "Mod+Ctrl+K".action.move-window-up = { };
        "Mod+Ctrl+L".action.move-column-right = { };

        "Mod+Home".action.focus-column-first = { };
        "Mod+End".action.focus-column-last = { };

        ##### Sizing #####

        "Mod+F".action.maximize-column = { };
        "Mod+Shift+F".action.fullscreen-window = { };
        "Mod+R".action.switch-preset-column-width = { };
        "Mod+Shift+R".action.reset-window-height = { };
        "Mod+C".action.center-column = { };
        "Mod+Minus".action.set-column-width = "-10%";
        "Mod+Equal".action.set-column-width = "+10%";
        "Mod+V".action.toggle-window-floating = { };

        ##### Screenshots (grim + slurp) #####

        # Region select -> clipboard
        "Mod+S".action.spawn-sh = ''grim -g "$(slurp)" - | wl-copy'';

        # Region select -> clipboard AND file
        "Mod+Shift+S".action.spawn-sh = ''
          grim -g "$(slurp)" - \
            | tee "$HOME/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png" \
            | wl-copy
        '';

        # Whole output -> clipboard
        "Ctrl+Print".action.spawn-sh = ''grim - | wl-copy'';

        # Focused window. grim has no window mode, so this stays on niri's
        # built-in picker, which writes to screenshot-path below.
        "Alt+Print".action.screenshot-window = { };

        ##### Media keys #####

        "XF86AudioRaiseVolume" = {
          allow-when-locked = true;
          action.spawn = [ "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.05+" ];
        };
        "XF86AudioLowerVolume" = {
          allow-when-locked = true;
          action.spawn = [ "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.05-" ];
        };
        "XF86AudioMute" = {
          allow-when-locked = true;
          action.spawn = [ "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle" ];
        };
      }

      ##### Workspaces 1-9 #####
      #
      # kdl requires nine literal lines each for focus and move. In Nix these
      # generate cleanly:
      #   Mod+1..9        { focus-workspace N; }
      #   Mod+Shift+1..9  { move-column-to-workspace N; }
      //
      builtins.listToAttrs (
        lib.concatMap
          (n: [
            {
              name = "Mod+${toString n}";
              value.action.focus-workspace = n;
            }
            {
              name = "Mod+Shift+${toString n}";
              value.action.move-column-to-workspace = n;
            }
          ])
          (lib.range 1 9)
      );
  };

  ############################################################
  # Packages referenced above
  ############################################################

  home.packages = with pkgs; [
    xwayland-satellite
    wl-clipboard
    swaybg
    grim
    slurp
  ];

  # ghostty, configured declaratively rather than via ~/.config/ghostty/config
  programs.ghostty = {
    enable = true;
    settings = {
      font-family = "JetBrainsMono Nerd Font";
      font-size = 12;
      window-decoration = false; # pairs with prefer-no-csd above
    };
  };

  # vicinae itself (package, layer shell, systemd scoping) is configured in
  # ./vicinae.nix, imported at the top of this file. Only the keybind that
  # talks to its daemon lives here.
}
