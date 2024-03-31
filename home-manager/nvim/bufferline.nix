{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = bufferline-nvim;
      type = "lua";
      config = ''
        require('bufferline').setup {
            options = {
                numbers = 'buffer_id',
                diagnostics = 'nvim_lsp',
                seperator_style = 'slant' or 'padded_slant',
                show_tab_indicators = true,
                show_buffer_close_icons = false,
                show_close_icon = false,
                offsets= {
                    filetype= "neo-tree",
                    text= "File Explorer",
                    highlight= "Directory",
                    separator_style = "slant",
                    text_align= "left"
                }
            },
        }
      '';
    }
  ];
}
