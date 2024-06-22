{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = which-key-nvim;
      type = "lua";
      config = ''
        local wk = require("which-key")
            wk.register(mappings, opts)

            vim.api.nvim_create_augroup("neotree", {})
            vim.api.nvim_create_autocmd("UiEnter", {
                    desc = "Open Neotree automatically",
                    group = "neotree",
                    callback = function()
                    if vim.fn.argc() == 0 and not vim.fn.exists "s:std_in" then
                    vim.cmd "Neotree toggle"
                    end
                    end,
                    })
      '';
    }
  ];
}
