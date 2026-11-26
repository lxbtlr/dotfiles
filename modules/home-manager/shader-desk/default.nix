{ config, lib, pkgs, inputs, ... }:
# shader-desk: interactive GLSL wallpaper engine on zwlr_layer_shell's
# background layer. Source: https://gitea.com/SeeTheWall/shader-desk
#
# User state lives in ~/.config/interactive-wallpaper (init.lua picks the
# scene per output, effects/ holds editable plugin copies). It is left
# mutable on purpose so hot-reload editing of .glsl/.lua files works.
let
  # Built here rather than taken from the flake's `packages` output: that
  # output is evaluated with the upstream flake's own nixpkgs instance,
  # which has allowUnfree = false, and the bundled shaders/assets are
  # CC-BY-NC-SA (unfree in nixpkgs' terms). Building with this module's
  # `pkgs` uses home.nix's nixpkgs.config, where allowUnfree = true.
  # Mirrors the derivation in upstream's flake.nix — keep in sync if their
  # dependency list changes.
  shader-desk = pkgs.stdenv.mkDerivation {
    pname = "shader-desk";
    version = "git-${inputs.shader-desk.shortRev or "dirty"}";
    src = inputs.shader-desk;

    nativeBuildInputs = with pkgs; [
      cmake
      ninja
      pkg-config
      wayland-scanner
      python3
      makeWrapper
    ];

    buildInputs = with pkgs; [
      wayland
      wayland-protocols
      libGL
      luajit
      nlohmann_json
      glm
      sol2
      libpulseaudio
      fftw
      libevdev
      mpv
    ];

    cmakeFlags = [
      "-DBUILD_AUDIO_DAEMON=ON"
      "-DBUILD_EVDEV_DAEMON=ON"
      "-DENABLE_PROFILING=OFF"
    ];

    # EGL/GL drivers live in /run/opengl-driver on NixOS.
    postInstall = ''
      for prog in interactive-wallpaper shader-desk-run; do
        if [ -f "$out/bin/$prog" ]; then
          wrapProgram "$out/bin/$prog" \
            --prefix LD_LIBRARY_PATH : "/run/opengl-driver/lib:${
              lib.makeLibraryPath [ pkgs.libGL pkgs.mpv pkgs.wayland ]
            }"
        fi
      done
    '';

    meta = {
      description = "Interactive Wayland wallpaper engine";
      homepage = "https://gitea.com/SeeTheWall/shader-desk";
      license = with lib.licenses; [ mpl20 cc-by-nc-sa-40 ];
      platforms = lib.platforms.linux;
      mainProgram = "shader-desk-run";
    };
  };
  cfgDir = "${config.home.homeDirectory}/.config/interactive-wallpaper";

  # Any enabled output that isn't the laptop panel counts as "docked":
  # shader-desk is then stopped and noctalia's slideshow takes over on every
  # screen. Matching on "not eDP" covers every USB-C port (DP-1, DP-2, ...)
  # and HDMI, instead of naming one connector.
  internalOutputPrefix = "eDP";

  # Testing switch: true runs shader-desk on battery too (the monitor
  # check still applies). false = only run while the charger is connected.
  ignoreCharger = false;

  # Noctalia merges every *.toml in ~/.config/noctalia in sorted order, so
  # this file (sorting after config.toml) overrides wallpaper.enabled at
  # runtime without touching the Nix-managed config. Its inotify watch only
  # reacts to writes/renames, not deletes, so the file is always rewritten
  # rather than removed.
  noctaliaOverride = "${config.xdg.configHome}/noctalia/zz-shader-desk.toml";

  dockSwitch = pkgs.writeShellScript "shader-desk-dock-switch" ''
    set -u
    niri=${lib.getExe config.programs.niri.package}
    jq=${lib.getExe pkgs.jq}
    systemctl=${pkgs.systemd}/bin/systemctl
    udevadm=${pkgs.systemd}/bin/udevadm
    noctalia=${lib.getExe config.programs.noctalia.package}
    internal='${internalOutputPrefix}'
    override='${noctaliaOverride}'
    state=""

    noctalia_wallpaper() {
      mkdir -p "$(dirname "$override")"
      tmp=$(mktemp "$override.XXXXXX")   # not *.toml, so never half-read
      printf '[wallpaper]\nenabled = %s\n' "$1" > "$tmp"
      mv -f "$tmp" "$override"
      "$noctalia" msg config-reload >/dev/null 2>&1 || true
    }

    docked() {
      "$niri" msg --json outputs | "$jq" -e --arg internal "$internal" \
        '[ to_entries[] | select((.key | startswith($internal)) | not)
                        | select(.value.logical != null) ] | length > 0' \
        >/dev/null 2>&1
    }

    # "On AC" rather than the battery's literal "Charging" status: with a
    # charge limit set, the battery reports "Not charging" while plugged in
    # and would flip back and forth around the threshold.
    on_ac() {
      for ps in /sys/class/power_supply/*; do
        [ "$(cat "$ps/type" 2>/dev/null)" = Mains ] || continue
        [ "$(cat "$ps/online" 2>/dev/null)" = 1 ] && return 0
      done
      return 1
    }

    apply() {
      # shader-desk only when undocked AND plugged in; noctalia otherwise.
      if ! docked && { ${lib.boolToString ignoreCharger} || on_ac; }; then want=shader; else want=noctalia; fi
      [ "$want" = "$state" ] && return
      state=$want
      echo "switching to $want"
      if [ "$want" = noctalia ]; then
        "$systemctl" --user stop shader-desk.service
        noctalia_wallpaper true
      else
        noctalia_wallpaper false
        "$systemctl" --user start shader-desk.service
      fi
    }

    apply
    # Two event sources merged into one stream:
    #  - niri has no output-change event, but connecting or removing a
    #    monitor always reshuffles workspaces, so WorkspacesChanged is the
    #    monitor trigger.
    #  - udev power_supply events fire on plug/unplug (and on battery level
    #    changes, which are harmless since apply only acts on a change).
    # If either source dies, both are killed so systemd restarts the unit.
    {
      "$niri" msg --json event-stream &
      "$udevadm" monitor --udev --subsystem-match=power_supply &
      wait -n
      kill $(jobs -p) 2>/dev/null
    } | while read -r line; do
      case "$line" in
        *'"WorkspacesChanged"'* | *power_supply*) apply ;;
      esac
    done
  '';
in
{
  home.packages = [ shader-desk ];

  # Extra scenes kept in the dotfiles. shader-desk loads the ShaderToy
  # plugin from the package in the store, so it looks for shaders next to
  # the plugin there, not in ~/.config/interactive-wallpaper/effects. Its
  # loader joins paths with std::filesystem, where an absolute file name
  # replaces the plugin folder, so each scene gets its shader's store path
  # substituted in for @SHADER@.
  xdg.configFile."interactive-wallpaper/scenes/balatro.lua".text =
    builtins.replaceStrings [ "@SHADER@" ] [ "${./shaders/balatro.glsl}" ]
      (builtins.readFile ./scenes/balatro.lua);

  # --init-workspace copies plugin sources and .so files out of the store.
  # Two NixOS-specific problems with that, both handled here:
  #   1. std::filesystem::copy keeps the store's read-only modes, so the
  #      copied shaders can't be edited until made writable.
  #   2. The .so files are copied with update_existing, which compares
  #      mtimes. Store files are dated 1970, so after a package upgrade the
  #      workspace keeps the *old* .so forever — and the workspace has
  #      priority over the system plugin dir. Deleting the packaged plugins'
  #      .so copies first forces a fresh copy each switch. Only names that
  #      the package ships are removed, so self-compiled plugins survive.
  # It runs from an empty temp dir because the engine also searches
  # ./plugins and ../plugins relative to the working directory.
  home.activation.shaderDeskWorkspace =
    lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      effects="${cfgDir}/effects"
      if [ -d "$effects" ]; then
        for so in ${shader-desk}/lib/shader-desk/plugins/*/*.so; do
          name=$(basename "$so")
          run rm -f "$effects/''${name%.so}/$name"
        done
      fi

      tmp=$(mktemp -d)
      (
        cd "$tmp"
        run ${shader-desk}/bin/interactive-wallpaper --init-workspace \
          || echo "shader-desk: --init-workspace failed" >&2
        # Only generate configs on first run; afterwards init.lua is yours.
        # Re-run `interactive-wallpaper --init-config` by hand after an
        # upgrade to pick up new plugins (it merges, keeping your values).
        if [ ! -e "${cfgDir}/init.lua" ]; then
          run ${shader-desk}/bin/interactive-wallpaper --init-config \
            || echo "shader-desk: --init-config failed" >&2
        fi
      )
      rm -rf "$tmp"
      [ -d "${cfgDir}" ] && run chmod -R u+w "${cfgDir}"
    '';

  # Upstream ships a unit pointing at /usr/bin, so define our own.
  # shader-desk-run starts the audio + evdev daemons and then the engine.
  systemd.user.services.shader-desk = {
    Unit = {
      Description = "shader-desk interactive wallpaper";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
      # Plasma manages its own wallpaper; keep this to niri only.
      ConditionEnvironment = "XDG_CURRENT_DESKTOP=niri";
      X-Restart-Triggers = [ "${shader-desk}" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${shader-desk}/bin/shader-desk-run";
      WorkingDirectory = cfgDir;
      Restart = "on-failure";
      RestartSec = 3;
    };
    # No WantedBy: shader-desk-dock decides when this runs.
  };

  # Starts/stops shader-desk and flips noctalia's wallpaper depending on
  # whether an external monitor is connected and whether AC is plugged in.
  systemd.user.services.shader-desk-dock = {
    Unit = {
      Description = "Switch between shader-desk and noctalia wallpaper on dock/power";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
      ConditionEnvironment = "XDG_CURRENT_DESKTOP=niri";
      X-Restart-Triggers = [ "${dockSwitch}" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${dockSwitch}";
      # The event stream ends if niri reloads its IPC; just reconnect.
      Restart = "always";
      RestartSec = 2;
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };
}
