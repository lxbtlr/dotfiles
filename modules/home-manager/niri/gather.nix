# niri-gather — pull every window from other monitors onto the focused one.
#
# HOME-MANAGER module. Import from home.nix alongside your other niri files.
#
# Why windows rather than workspaces: `move-workspace-to-monitor --reference`
# takes an index or a name, and niri's own docs note that idx is per-monitor
# and "workspaces on different monitors can have the same index" — so an index
# cannot unambiguously identify an off-screen workspace. Window ids are unique
# and stable, so we move windows.
#
# Trade-off: windows land on the target monitor's active workspace, so
# grouping is not preserved. See niri-gather-named below if you want that.

{ pkgs, ... }:

let
  gather = pkgs.writeShellApplication {
    name = "niri-gather";
    runtimeInputs = with pkgs; [ niri jq ];
    text = ''
      target=$(niri msg -j focused-output | jq -r .name)

      if [ -z "$target" ] || [ "$target" = "null" ]; then
        echo "niri-gather: could not determine focused output" >&2
        exit 1
      fi

      # Window ids living on any output other than the target.
      mapfile -t ids < <(
        jq -n \
          --arg out "$target" \
          --argjson ws "$(niri msg -j workspaces)" \
          --argjson wins "$(niri msg -j windows)" '
            ($ws | map(select(.output != $out) | .id)) as $off
            | $wins[]
            | select(.workspace_id as $w | $off | index($w))
            | .id
          '
      )

      if [ ''${#ids[@]} -eq 0 ]; then
        echo "niri-gather: nothing to move; all windows already on $target"
        exit 0
      fi

      for id in "''${ids[@]}"; do
        niri msg action move-window-to-monitor --id "$id" "$target"
      done

      echo "niri-gather: moved ''${#ids[@]} window(s) to $target"
    '';
  };

  # Grouping-preserving variant: only handles NAMED workspaces, because names
  # are unique across monitors while indices are not.
  gatherNamed = pkgs.writeShellApplication {
    name = "niri-gather-named";
    runtimeInputs = with pkgs; [ niri jq ];
    text = ''
      target=$(niri msg -j focused-output | jq -r .name)

      mapfile -t names < <(
        niri msg -j workspaces \
          | jq -r --arg out "$target" '
              .[] | select(.output != $out and .name != null) | .name
            '
      )

      for name in "''${names[@]}"; do
        niri msg action move-workspace-to-monitor "$target" --reference "$name"
      done

      echo "niri-gather-named: moved ''${#names[@]} workspace(s) to $target"
    '';
  };
in
{
  home.packages = [
    gather
    gatherNamed
  ];

  # Bind them. Mod+G for windows, Mod+Shift+G to gather named workspaces.
  programs.niri.settings.binds = {
    "Mod+G".action.spawn = "niri-gather";
    "Mod+Shift+G".action.spawn = "niri-gather-named";
  };
}
