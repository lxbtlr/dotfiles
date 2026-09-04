# Locally patched mimir plugin for noctalia.
#
# HOME-MANAGER module. Import from home.nix AFTER ./noctalia.nix.
#
# Two upstream bugs this works around:
#
#   1. service.luau hardcodes "deepseek-v4-flash" as the model default. Your
#      endpoint serves "deepseek/DeepSeek-V4-Flash", so every request is
#      rejected until the picker is used.
#
#   2. fetchModels() calls noctalia.http({ url = url }) with no headers, so
#      GET <endpoint>/models is unauthenticated. On a server that requires a
#      key there, res.ok is false, the function returns silently, and the
#      dropdown stays empty — which means the picker can never be used to fix
#      bug 1. The two compound into a dead end.
#
# noctalia's Path source kind is documented as "an immutable local directory
# (e.g. a Nix store path) the host treats read-only" — update, auto-update and
# remove all become no-ops, so this survives auto_update = true.

{ pkgs, lib, ... }:

let
  # Pin the upstream repo. Bump rev + hash to pick up plugin updates; the
  # substitutions below will fail loudly if upstream changes those lines.
  community-plugins = pkgs.fetchFromGitHub {
    owner = "noctalia-dev";
    repo = "community-plugins";
    rev = "37856683875fbec2c9ac027e5e6143e11231d1d2";
    hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
  };

  # The model string your endpoint actually serves.
  model = "deepseek/DeepSeek-V4-Flash";

  patched-plugins = pkgs.runCommand "noctalia-plugins-patched" { } ''
    mkdir -p $out
    cp -r ${community-plugins}/mimir $out/mimir
    chmod -R +w $out/mimir

    cd $out/mimir

    # --- bug 1: hardcoded model default ---------------------------------
    substituteInPlace service.luau \
      --replace-fail '"deepseek-v4-flash"' '"${model}"'

    # --- bug 2: fetchModels sends no credentials ------------------------
    # Give the /models request the same Authorization header the chat call
    # uses. loadConfig() is already in scope at this point in the file.
    substituteInPlace service.luau \
      --replace-fail \
        'noctalia.http({ url = url }, function(res)' \
        'noctalia.http({ url = url, headers = { Authorization = "Bearer " .. (config.api_key or "") } }, function(res)'

    # Fail the build if either marker was not found, rather than silently
    # shipping an unpatched plugin. --replace-fail already does this, but be
    # explicit about the result for anyone reading the log.
    grep -q '${model}' service.luau
    grep -q 'Authorization' service.luau
  '';
in
{
  programs.noctalia.settings.plugins = {
    # Declaring any source replaces the default seeding, so the two upstream
    # repos are listed explicitly alongside the local override.
    source = [
      {
        kind = "git";
        name = "official";
        location = "https://github.com/noctalia-dev/official-plugins";
      }
      {
        kind = "git";
        name = "community";
        location = "https://github.com/noctalia-dev/community-plugins";
        # Disabled so it cannot also offer an unpatched alexander/mimir.
        # Re-enable if you want other community plugins, but see the note in
        # the accompanying message about id collisions.
        enabled = false;
      }
      {
        kind = "path";
        name = "local";
        location = "${patched-plugins}";
      }
    ];

    enabled = [ "alexander/mimir" ];

    auto_update = true; # no-op for the path source

    plugin_settings."alexander/mimir" = {
      # Must be the URL that returns 200 for <endpoint>/models.
      # No trailing slash; include the version segment.
      # api_endpoint = "http://your-host:port/v1";
      # api_key = "REPLACE_ME";
      web_search_enabled = true;
      show_commands = true;
    };
  };
}
