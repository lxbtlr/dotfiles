{
  programs.nixvim = {
    plugins.which-key = {
      enable = true;
      settings.spec = [
        {"<leader>m" = "󱋼 Marks";}
        {"<leader>t" = "🗄️Neotree";}
        {"<leader>w" = " Window";}
        {"<leader>d" = " DELETE";}
        {"<leader>n" = " Find Notes";}
        {"<leader>tp" = "󰒋 Panel";}
        {"<leader>st" = "🧷 Show Tags";}
        {"<leader>gn" = "📔 Search Notes";}
        {"<leader>ii" = "🔗 Insert Note Link";}
        {"<ENTER>" = "🎯 Insert Note Link";}
        {"<leader><ENTER>" = "📄 New Note";}
        {"<leader>ny" = "🤏 Yank Note link";}
        {"<leader>nt" = "📂 New Template Note";}
        {"<leader>l" = "🖇️ Backlinks?!";}
        {"<leader>fn" = "🆔 Search Notes";}
        {"<leader>" = "🆔 Search Notes";}
      ];
    };
    plugins.bufdelete.enable = true;
    extraConfigLua = ''
    '';
    #extraConfigLua = ''
    #  local wk = require("which-key")
    #    wk.register(mappings, opts)
    #    vim.api.nvim_create_augroup("neotree", {})
    #    vim.api.nvim_create_autocmd("UiEnter", {
    #      desc = "Open Neotree automatically",
    #      group = "neotree",
    #      callback = function()
    #      if vim.fn.argc() == 0 and not vim.fn.exists "s:std_in" then
    #      vim.cmd "Neotree toggle"
    #      end
    #      end,
    #      })
    #'';
  };
}
