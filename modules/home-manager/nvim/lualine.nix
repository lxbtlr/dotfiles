{
  programs.nixvim.plugins.web-devicons.enable= true;
  programs.nixvim.plugins.lualine = {

    enable = true;
    settings.options.icons_enabled = true;
    settings.options.always_divide_middle = true;
    settings.options.globalstatus = false;
    settings.options.ignore_focus = ["neo-tree"];
    settings.options.theme = "auto";
    settings.options.component_separators = {
      left = "";
      right = "";
    };
    settings.options.section_separators = {
      left = "";
      right = "";
    };
    settings.options.refresh = {
      statusline = 1000;
      tabline = 1000;
      winbar = 1000;
    };
    settings.extensions = ["fzf"];
    settings.sections = {
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
    settings.inactive_sections = {
      lualine_a = [];
      lualine_b = [];
      lualine_c = ["filename"];
      lualine_x = ["location"];
      lualine_y = [];
      lualine_z = [];
    };
  };
}
