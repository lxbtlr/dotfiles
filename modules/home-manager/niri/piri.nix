# piri — niri extension daemon, scratchpads plugin.
#
# HOME-MANAGER module. Import from home.nix.
#
# Requires the flake input:
#   piri.url = "github:Asthestarsfalll/piri";
# and `inputs` in scope (you already pass it via extraSpecialArgs).
#
# piri has a flake with packages.default but no home-manager module, so the
# package, the TOML config and the systemd unit are all wired up by hand here.
#
# NOTE: piri's flake does NOT declare inputs.nixpkgs.follows, so by default it
# builds against its own pinned nixpkgs. That is a second nixpkgs evaluation.
# Adding `inputs.piri.inputs.nixpkgs.follows = "nixpkgs";` in flake.nix avoids
# it, at the cost of building against a nixpkgs the author did not test.

{ config, lib, pkgs, inputs, ... }:

let
  piri = inputs.piri.packages.${pkgs.stdenv.hostPlatform.system}.default;

  piriConfig = {
    piri.plugins = {
      scratchpads = true;
      # Everything else off until you want it — piri disables plugins by
      # default, so listing them false is documentation rather than necessity.
      sticky = false;
      swallow = false;
      singleton = false;
      window_rule = false;
      workspace_rule = false;
      window_order = false;
      mark = false;
      empty = false;
    };

    piri.scratchpad = {
      default_size = "40% 60%";
      default_margin = 50;
      # Keeps hidden scratchpads out of the current workspace's stack.
      # move_to_workspace = "tmp";
    };

    scratchpads = {
      # Dropdown terminal. --class sets the app_id ghostty reports.
      term = {
        direction = "fromTop";
        command = "${pkgs.ghostty}/bin/ghostty --class=float.dropterm";
        # app_id is a REGEX, so the dot must be escaped.
        app_id = "float\\.dropterm";
        size = "70% 50%";
        margin = 50;
      };

      # Launcher-adjacent scratch note.
      note = {
        direction = "fromRight";
        command = "${pkgs.ghostty}/bin/ghostty --class=float.notes -e nvim ~/notes.md";
        app_id = "float\\.notes";
        size = "50% 70%";
        margin = 50;
      };
    };
  };

  tomlFormat = pkgs.formats.toml { };
in
{
  home.packages = [ piri ];

  xdg.configFile."niri/piri.toml".source =
    tomlFormat.generate "piri.toml" piriConfig;

  # piri talks to niri's socket, so it must start after the compositor and
  # stop with it. graphical-session.target is reached after niri is up.
  systemd.user.services.piri = {
    Unit = {
      Description = "piri — niri extension daemon";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
      # Scoped to niri, like waybar and vicinae.
      ConditionEnvironment = "XDG_CURRENT_DESKTOP=niri";
    };
    Service = {
      Type = "simple";
      ExecStart = "${piri}/bin/piri daemon";
      Restart = "on-failure";
      RestartSec = 3;
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };

  # Binds. piri talks to the running daemon; these are plain spawns.
  programs.niri.settings.binds = {
    "Mod+Grave" = {
      hotkey-overlay.title = "Toggle dropdown terminal";
      action.spawn = [ "${piri}/bin/piri" "scratchpads" "term" "toggle" ];
    };
    "Mod+Shift+N" = {
      hotkey-overlay.title = "Toggle scratch notes";
      action.spawn = [ "${piri}/bin/piri" "scratchpads" "note" "toggle" ];
    };
    # Promote whatever is focused into an ad-hoc scratchpad.
    "Mod+Shift+Grave" = {
      hotkey-overlay.title = "Add focused window as scratchpad";
      action.spawn = [ "${piri}/bin/piri" "scratchpads" "adhoc" "add" "fromRight" ];
    };
  };
}
