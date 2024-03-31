{
  pkgs,
  config,
  root,
  ...
}: let
  #color = pkgs.writeText "color.vim" (import ./theme.nix config.colorscheme);
in {
  imports = [
    ./bufferline.nix
    ./lualine.nix
    ./blankline.nix
    ./whichkey.nix
  ];
  home.sessionVariables.EDITOR = "nvim";

  programs.neovim = {
    # Nix options
    viAlias = true;
    vimAlias = true;
    enable = true;
    withPython3 = true;

    # basic plugins

    plugins = with pkgs.vimPlugins; [
      hydra-nvim

      venn-nvim
      neogit
      todo-comments-nvim
      glow-nvim
      telescope-nvim
      telescope-zoxide
      vim-visual-multi
      nvim-treesitter
      nvim-web-devicons
      coc-nvim
      coc-python
      coc-pyright
      which-key-nvim
      neo-tree-nvim
      {
      plugin = tokyonight-nvim;
      config = "colorscheme tokyonight";
      }
      #{
      #  plugin = oxocarbon-nvim;
      #  config = "colorscheme oxocarbon";
      #}
      {
        plugin = vim-autoformat;
        config = "au BufWrite * :Autoformat
                let g:autoformat_autoindent=0
                let g:autoformat_retab = 0
                let g:autoformat_remove_trailing_spaces = 1";
      }
    ];

    extraPackages = with pkgs; [
      (python3.withPackages (ps:
        with ps; [
          black
          flake8
        ]))
    ];
    extraPython3Packages = ps:
      with ps; [
        jedi
      ];

    # basic vim config
    extraConfig = ''
      nnoremap <SPACE> <Nop>
      let mapleader=" "
      nnoremap <leader>ff <cmd>Telescope find_files<cr>
      nnoremap <leader>fg <cmd>Telescope live_grep<cr>
      nnoremap <leader><leader> <cmd>Telescope buffers<cr>
      nnoremap <leader>fh <cmd>Telescope help_tags<cr>
      nnoremap <leader>t  <cmd>Neotree<cr>

      set termguicolors

      inoremap <silent><expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
      inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
      inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"

      nnoremap <Up> <Nop>
      nnoremap <Down> <Nop>
      nnoremap <Left> <Nop>
      nnoremap <Right> <Nop>

      inoremap <Up> <Nop>
      inoremap <Down> <Nop>
      inoremap <Left> <Nop>
      inoremap <Right> <Nop>

      set nocompatible            " disable compatibility to old-time vi
      set showmatch               " show matching
      set ignorecase              " case insensitive
      set mouse=v                 " middle-click paste with
      set hlsearch                " highlight search
      set incsearch               " incremental search
      set tabstop=2               " number of columns occupied by a tab
      set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
      set expandtab               " converts tabs to white space
      set shiftwidth=4            " width for autoindents
      set autoindent              " indent a new line the same amount as the line just typed
      set number                  " add line numbers
      set wildmode=longest,list   " get bash-like tab completions
      set cc=80                   " set an 80 column border for good coding style
      filetype plugin indent on   " allow auto-indenting depending on file type
      syntax on                   " syntax highlighting
      set clipboard=unnamedplus   " using system clipboard
      filetype plugin on
      set cursorline              " highlight current cursorline
      set ttyfast                 " Speed up scrolling in Vim'';

    extraLuaConfig = ''
          require("todo-comments").setup()
          local neogit = require('neogit')
          neogit.setup {}
      require('glow').setup({
              style = "dark",
              width = 120,
              })

    '';
  };
}
