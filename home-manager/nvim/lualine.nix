{
  programs.nixvim.plugins.lualine = {
    enable = true;
    iconsEnabled = true;
    alwaysDivideMiddle = true;
    globalstatus = false;
    ignoreFocus = ["neo-tree"];
    extensions = ["fzf"];
    theme = "auto";
    componentSeparators = {
      left = "";
      right = "";
    };
    sectionSeparators = {
      left = "";
      right = "";
    };
    refresh = {
      statusline = 1000;
      tabline = 1000;
      winbar = 1000;
    };
    sections = {
      lualine_a = ["mode"];
      lualine_b = [
        {
          name = "branch";
          icon = "";
        }
        "diff"
        "diagnostics"
      ];
      lualine_c = ["filename"];
      lualine_x = ["encoding" "fileformat" "filetype"];
      lualine_y = ["progress"];
      lualine_z = ["loaction"];
    };
    inactiveSections = {
      lualine_a = [];
      lualine_b = [];
      lualine_c = ["filename"];
      lualine_x = ["location"];
      lualine_y = [];
      lualine_z = [];
    };
  };
}
