# editor.nix
# for all the text editor settings
{pkgs, config, root, ...}:

{
# TODO: Break this file into smaller parts, such as lauvim config, neotree, etc

  programs.neovim = {
    viAlias = true;
    vimAlias = true; 
    enable = true;
    withPython3 = true;
    plugins = with pkgs.vimPlugins; [
      hydra-nvim
      gitsigns-nvim
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
        plugin = oxocarbon-nvim;
        config = "colorscheme oxocarbon";
      }
      {
      	plugin = indent-blankline-nvim;
        config = ''let g:indent_blankline_use_treesitter=v:true'';
      }
      
      {
        plugin = bufferline-nvim;
        config = "set termguicolors";
      }
      lualine-nvim
    ];

    extraPackages = with pkgs; [
      (python3.withPackages (ps: with ps; [
        black
        flake8
      ]))
    ];
    extraPython3Packages = (ps: with ps; [
      jedi
    ]);

    # VimScript config TODO: move this into an import
    extraConfig = ''
      nnoremap <SPACE> <Nop>
      let mapleader=" "
      nnoremap <leader>ff <cmd>Telescope find_files<cr>
      nnoremap <leader>fg <cmd>Telescope live_grep<cr>
      nnoremap <leader><leader> <cmd>Telescope buffers<cr>
      nnoremap <leader>fh <cmd>Telescope help_tags<cr>
      nnoremap <leader>t  <cmd>Neotree<cr>
     
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

    # Lua config TODO: move this into an import
    extraLuaConfig = ''
      local neo_tree = require("neo-tree") 
      require("todo-comments").setup()
      local neogit = require('neogit')
      neogit.setup {}
      require('glow').setup({
	  style = "dark",
	  width = 120,
      })

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
      
      
      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'auto',
          component_separators = { left = '', right = ''},
          section_separators = { left = '', right = ''},
          disabled_filetypes = {
            statusline = {"neo-tree"},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = false,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          }
        },
        sections = {
          lualine_a = {'mode'},
          lualine_b = {'branch', 'diff', 'diagnostics'},
          lualine_c = {'filename'},
          lualine_x = {'encoding', 'fileformat', 'filetype'},
          lualine_y = {'progress'},
          lualine_z = {'location'}
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {'filename'},
          lualine_x = {'location'},
          lualine_y = {},
          lualine_z = {}
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {}
      }

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
  };
}
