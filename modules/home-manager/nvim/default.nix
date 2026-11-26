{
  pkgs,
  lib,
  config,
  inputs,
  root,
  ...
}: {
  imports = [
    inputs.nixvim.homeModules.nixvim
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

    ./csv.nix
    ./lsp/lspsaga.nix
    ./lsp/lsp.nix
    #./lsp/fidget.nix
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
      diffview = {
        enable = true;
        #extraConfigLua = ''
        #  require('diffview').setup {
        #    view = {
        #      default = { winbar_info = true },
        #      file_history = { winbar_info = true },
        #    },
        #  }
        #'';
      };

      project-nvim = {
        enable = true;
        enableTelescope = true;
        settings ={
          lsp={enabled= true;};
          patterns= [
          "flake.nix"
          "README.md"
          ".git"
          "_darcs"
          ".hg"
          ".bzr"
          ".svn"
          "Makefile"
          "package.json"
          "pyproject.toml" 
          ];
          extraConfigVim = ''
            require("project_nvim").setup {  }
          '';
        };
      };
      #can add telescope options here if ya want with extraOptions.keymaps
      vimtex = {
        enable = false;
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

      goyo.enable = true;

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

      # No nixvim module for limelight (goyo is under plugins.goyo).
      limelight-vim

      #coc-nvim
      #coc-python
      #coc-pyright
      #{
      #  plugin = vim-autoformat;
      #  #config = "au BufWrite * :Autoformat
      #  #        let g:autoformat_autoindent=0
      #  #        let g:autoformat_retab = 0
      #  #        let g:autoformat_remove_trailing_spaces = 0";
      #}
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

      " Limelight dims everything but the current paragraph; tie it to Goyo
      " so it turns on and off with :Goyo.
      " Goyo blanks the status lines of its padding windows, but lualine
      " redraws its own status line in every window once a second and puts
      " them back. Pause lualine for the duration of Goyo, then re-hide the
      " status line (laststatus=0) in case lualine had already re-enabled it.
      " nocursorline: the cursor-line highlight paints over Goyo's background
      " and Limelight's dimming. Goyo runs in its own tab, so this only hits
      " the Goyo window and your normal windows keep cursorline.
      autocmd! User GoyoEnter Limelight | setlocal nocursorline | lua require('lualine').hide(); vim.o.laststatus = 0
      autocmd! User GoyoLeave Limelight! | lua require('lualine').hide({ unhide = true })
    '';
    extraConfigLua = ''
      require('glow').setup({
              style = "dark",
              width = 120,
              })

      -- render-markdown draws inline `code` (and ==highlights==) with
      -- RenderMarkdownCode, which by default just links to ColorColumn.
      -- On :Goyo, Goyo repaints ColorColumn with fg = bg = background so
      -- the colour column disappears, which also makes that text
      -- invisible. Copy ColorColumn's real colours into the render-markdown
      -- group so it no longer follows Goyo's change. Re-run on every
      -- colourscheme load; Goyo reloads the colourscheme when you leave it.
      local function pin_markdown_code_hl()
        local cc = vim.api.nvim_get_hl(0, { name = 'ColorColumn', link = false })
        vim.api.nvim_set_hl(0, 'RenderMarkdownCode', cc)
      end
      pin_markdown_code_hl()
      vim.api.nvim_create_autocmd('ColorScheme', { callback = pin_markdown_code_hl })
    '';
  };
}
