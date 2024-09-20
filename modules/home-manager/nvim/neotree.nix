{
  plugins.neo-tree = {
    enable = false;
    enableDiagnostics = true;
    enableGitStatus = true;
    enableModifiedMarkers = true;
    enableRefreshOnWrite = true;
    enableNormalModeForInputs = false;
    sortCaseInsensitive = false;
    closeIfLastWindow = true;
    popupBorderStyle = "rounded"; # Type: null or one of “NC”, “double”, “none”, “rounded”, “shadow”, “single”, “solid” or raw lua code
    buffers = {
      bindToCwd = false;
      followCurrentFile = {
        enabled = true;
      };
    };
    window = {
      width = 40;
      height = 15;
      autoExpandWidth = false;
      mappings = {
        S = "noop";
        ["<c-v>"] = "open_vsplit";
        ["<c-x>"] = "open_split";
        ["<cr>"] = "open_drop";
        o = "system_open";
        s = "noop";
        t = "noop";
      };
    };
  };

