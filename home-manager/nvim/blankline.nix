{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = indent-blankline-nvim;
      type = "vim";
      config = ''
        let g:indent_blankline_use_treesitter=v:true

            vim.cmd [[highlight IndentBlanklineIndent1 guifg=#000000 gui=nocombine]]
            vim.cmd [[highlight IndentBlanklineIndent2 guifg=#08bdba gui=nocombine]]
            vim.cmd [[highlight IndentBlanklineIndent3 guifg=#ee5396 gui=nocombine]]
            vim.cmd [[highlight IndentBlanklineIndent4 guifg=#42be65 gui=nocombine]]
            vim.cmd [[highlight IndentBlanklineIndent5 guifg=#78a9ff gui=nocombine]]
            vim.cmd [[highlight IndentBlanklineIndent6 guifg=#000000 gui=nocombine]]

            vim.opt.list = true
            vim.opt.listchars:append "space:⋅"
            vim.opt.listchars:append "eol:↴"

            require("indent_blankline").setup {
                show_current_context = true,
                                     show_current_context_start = true,
                                     space_char_blankline = " ",
                                     char_highlight_list = {
                                         "IndentBlanklineIndent1",
                                         "IndentBlanklineIndent2",
                                         "IndentBlanklineIndent3",
                                         "IndentBlanklineIndent4",
                                         "IndentBlanklineIndent5",
                                         "IndentBlanklineIndent6",
                                     },
            }
      '';
    }
  ];
}
