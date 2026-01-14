{
  pkgs,
  lib,
  config,
  inputs,
  root,
  ...
}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./dashboard.nix
    ./bufferline.nix
    ./lualine.nix
    ./blankline.nix
    ./whichkey.nix
    ./autocmd.nix
    ./keybinds.nix
    ./sets.nix
    #./git.nix
    #./git.nix
    #./git.nix
    #./git.nix

    ./lsp/lspsaga.nix
     ./lsp/lsp.nix
    ./lsp/fidget.nix
    ./lsp/cmp.nix
    ./lsp/conform.nix
    ./lsp/luasnip.nix
  ];
  
  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    viAlias = true;
    vimAlias = true;

    luaLoader.enable = true;
    #colorschemes.tokyonight.enable = true;
    colorschemes.oxocarbon.enable = true;
    # nixvim packages with (little to) no config
    plugins = {
      nvim-autopairs.enable = true;
      neo-tree.enable = true;
      treesitter.enable = true;
      telescope.enable = true;
      render-markdown.enable=true;
      todo-comments.enable = true;
      #can add telescope options here if ya want with extraOptions.keymaps
      vimtex = {
        enable = true;
        settings = {
          compiler_method = "pdflatex";
          view_method = "sioyek";
          quickfix = 0;
          tex_conceal = "abdmg";
        };
        texlivePackage = null;
      };



      mini.enable = true;
      fidget.enable = true;
      neogit = {
        enable = true;
        settings = {
          keymaps = [
            {
              mode = "n";
              key = "<leader>jj";
              action = "<cmd>Neogit<CR>";
            }
          ];
        };
      };

      gitsigns = {
        enable = true;
        settings = {
          current_line_blame = true;
          trouble = false;
        };
      };
    };

    # catch all for non nixvim implemented packages
    extraPlugins = with pkgs.vimPlugins; [
      vim-tmux-clipboard
      #telekasten-nvim
      hydra-nvim
      venn-nvim
      glow-nvim
      telescope-zoxide
      vim-visual-multi
      nvim-web-devicons
      calendar-vim
      #coc-nvim
      #coc-python
      #coc-pyright
      {
        plugin = vim-autoformat;
        config = "au BufWrite * :Autoformat
                let g:autoformat_autoindent=0
                let g:autoformat_retab = 0
                let g:autoformat_remove_trailing_spaces = 0";
      }
    ];
    extraConfigVim = ''
      " delete without yanking
      nnoremap <leader>d "_d
      vnoremap <leader>d "_d

      set foldmethod=manual
      nnoremap <cr> za
      vnoremap <cr> za

      " replace currently selected text with default register
      " without yanking it
      vnoremap <leader>p "_dP
    '';
    extraConfigLua = ''
      require('glow').setup({
              style = "dark",
              width = 120,
              })
    '';
  };
}
