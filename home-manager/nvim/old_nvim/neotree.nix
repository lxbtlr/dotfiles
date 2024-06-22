{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = neo-tree-nvim;
      type = "lua";
      config =
        /*
        ADD CONFIG HERE
        */
        ''
              local neo_tree = require("neo-tree")
              neo_tree.setup({
                  close_if_last_window = true,
                  popup_border_style = "rounded",
                  enable_git_status = true,
                  enable_diagnostics = true,
                  enable_normal_mode_for_inputs = false,
                  open_files_do_not_replace_types = { "terminal", "trouble", "qf" },
                  sort_case_insensitive = false,

                  default_component_configs = {
                  icon = {
                  default = "",
                  },
                  },
                  event_handlers = {
                  {
                  event = "file_opened",
                  handler = function()
                  require("neo-tree.command").execute({ action = "close" })
                  end,
                  },
                  },
                  filesystem = {
                      commands = {
                          system_open = function(state)
                              local path = state.tree:get_node():get_id()
                                                                 vim.loop.spawn(
                                                                         "@xdg_utils@/bin/xdg-open",
                                                                         { args = { path } },
                                                                         function(code)
                                                                         if code ~= 0 then
                                                                         vim.notify(
                                                                             "xdg-open " .. path .. " exited with code " .. code,
                                                                             vim.log.levels.WARN
                                                                             )
                                                                         end
                                                                         end
                                                                         )
                                                                     end,
                      },
                      filtered_items = {
                          hide_by_name = { ".git" },
                          hide_dotfiles = false,
                          show_hidden_count = false,
                          use_libuv_file_watcher = true,
                      },
                      find_by_full_path_words = true,
                      window = {
                          mappings = {
                              ["<c-_>"] = "clear_filter",
                          },
                      },
                  },
                  popup_border_style = "single",
                  use_popups_for_input = false,
                  window = {
                      width = 32,
                      mappings = {
                          S = "noop",
                          ["<c-v>"] = "open_vsplit",
                          ["<c-x>"] = "open_split",
                          ["<cr>"] = "open_drop",
                          o = "system_open",
                          s = "noop",
                          t = "noop",
                      },
                  },
          })
        '';
    }
  ];
}
