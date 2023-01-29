set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc


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
set tabstop=4               " number of columns occupied by a tab 
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line numbers
set wildmode=longest,list   " get bash-like tab completions
set cc=80                  " set an 80 column border for good coding style
filetype plugin indent on   "allow auto-indenting depending on file type
syntax on                   " syntax highlighting
set clipboard=unnamedplus   " using system clipboard
filetype plugin on
set cursorline              " highlight current cursorline
set ttyfast                 " Speed up scrolling in Vim
" set spell                 " enable spell check (may need to download language package)
" set noswapfile            " disable creating swap file
" set backupdir=~/.cache/vim " Directory to store backup files.
" open new split panes to right and below

set splitright
set splitbelow


call plug#begin('~/.vim/plugged')
" Plug 'echasnovski/mini.starter'
 Plug 'nvim-lua/plenary.nvim'
 Plug 'gelguy/wilder.nvim'
  " To use Python remote plugin features in Vim, can be skipped
 Plug 'roxma/nvim-yarp'
 Plug 'roxma/vim-hug-neovim-rpc'

 Plug 'Shatur/neovim-tasks'

 Plug 'lukas-reineke/indent-blankline.nvim'
 Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
 
 Plug 'sirver/ultisnips'
 Plug 'lervag/vimtex'
 
 Plug 'metakirby5/codi.vim'
 
 Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
 
 Plug 'nvim-lua/telescope.nvim'
 
 Plug 'srcery-colors/srcery-vim'
 
 Plug 'feline-nvim/feline.nvim'
 
 Plug 'dracula/vim'
 
 Plug 'ryanoasis/vim-devicons'
 Plug 'honza/vim-snippets'
 
 Plug 'scrooloose/nerdtree'
 Plug 'preservim/nerdcommenter'
 
 Plug 'mhinz/vim-startify', {'branch': 'center'}
 Plug 'neoclide/coc.nvim', {'branch': 'release'}
 
 Plug 'nvim-lualine/lualine.nvim'
 " If you want to have icons in your statusline choose one of these
 Plug 'kyazdani42/nvim-web-devicons'
call plug#end()

" wilder config
call wilder#setup({
      \ 'modes': [':', '/', '?'],
      \ 'next_key': '<Tab>',
      \ 'previous_key': '<S-Tab>',
      \ 'accept_key': '<Down>',
      \ 'reject_key': '<Up>',
      \ })

call wilder#set_option('renderer', wilder#popupmenu_renderer(wilder#popupmenu_palette_theme({
      \ 'border': 'rounded',
      \ 'max_height': '75%',
      \ 'min_height': 0,
      \ 'prompt_position': 'top',
      \ 'reverse': 0,
      \ },)))

"call wilder#set_option('renderer', wilder#popupmenu_renderer({
"      \ 'highlighter': wilder#basic_highlighter(),
"      \ }))

let g:indent_blankline_use_treesitter=v:true
let g:indent_blankline_buftype_exclude = ['startify', 'dashboard']
let g:indent_blankline_filetype_exclude = ['startify']

let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'

 
"let g:startify_bookmarks = []
let g:startify_change_to_dir = 1
let g:startify_change_to_vcs_root = 0
let g:startify_change_cmd = 'lcd'
let g:startify_custom_header =    [
    \ "                                   .aggggga,,.                                                   ",
    \ "                                ,d888888888888888888888888888888888888888888888888888888P\"\"\"\"a,  ",
    \ "                               d8\"\"                                                    \`\"\"\"\"\"\"8  ",
    \ "                             ,8\"           ,_                 a,         .a ......:::::::::;dP\'  ",
    \ "                            ,8\";            8b              ..)8 ;;;;;;;;;)b;;;;;;;;;;;amd8\"\'    ",
    \ "                            8';.             88,    ...::::::;;8bagmgggg8888888PPPP\"\"\"\'\'         ",
    \ "                           ]8;:    8b        .\"888888888888888888\"\"\"\"        ..,aaaa,,.          ",
    \ "                          ,8\';.     8b   .::::;88\";;;;;d8\";:;:88\'       ,add88PPPPPPPP888baaa.   ",
    \ "                          dP;:.      \"8;;;;;;a888a;aadP\':;:;:8P     ,a8PPP\"\"                \"\"8  ",
    \ "                         ]8;::.       \"8a;;d8888888\"\';;:;:;a8\"  ,ad8P\"         .:.:,888888888 8) ",
    \ "                        ,8\";:.          \"88\';:;\"PPP8b;;;;;88,ad8P\'     ,a  I.:.:.:(8\'......`8 88 ",
    \ "                        dP;::.            \"Pba;;::::)8b:d88P\"\'         8 :(I:.:.:.(8::::::::8,8) ",
    \ "                       (8;::..                `\"\"P88PP\"\"            .: 8,.(8.:.,add88888888888\"  ",
    \ "                      ,8\";:.:.                                  ..::.::\"ga88888PP\"\"\'\'\'           ",
    \ "                     .8\";:.:..                              ..::.:,add8PP\'\'                      ",
    \ "                    .88;::::..                           .:.:;aad8P\"\'\'                           ",
    \ "                   .88;;:.:..                        ..:.:;adP\"\'                                 ",
    \ "                  .88;;::.:..                     ...:.:;dP\"                                     ",
    \ "                 .88;;:.::..                   ...:.::;d8\"                                       ",
    \ "                .88;;:.:.:..                 ...:.:.;d8\"                                         ",
    \ "               .88;;:.::.:.                ...:.::.;d8                                           ",
    \ "              .88;;:.::.:..              ...:.:.;;d8\"                                            ",
    \ "             .88;;:.:.:.:..            ...:.::.;;88                                              ",
    \ "            ,88;;:.:.:.:...          ...:.::.:;;88                                               ",
    \ "           d8\';;:.::.::.....       ....:.::.:;;88                                                ",
    \ "          88;;::.::.::........   ..:.::.::.;;d88                                                 ",
    \ "        .8P;;::.::.:............:.:.:.::;;a88P\"                                                  ",
    \ "       dP\';;::.:.:.............:..:.:;;ad8P\"                                                     ",
    \ "     .8P;;:.:.::..............:.:.:;d88P\"                                                        ",
    \ "    ,88;;.:.::................:.:;d8\"                                                            ",
    \ "    88;;.:.:................:.:;d8P                                                              ",
    \ "         \'\':::::...........:.;d8P                                                                ",
    \ "               \'\':::::....:.;d8\"                                                                   ",
    \ "                     \'\':::;d8\'                                                                    ",
    \]


 "   let g:startify_custom_header =  [
 "       \ "               ___________    ____ ",
 "       \ "       ______/   \\__//   \\__/____\\ "',
 "       \ "     _/   \\_/  :           //____\\\\ ",
 "       \ "    /|      :  :  ..      /        \\ ",
 "       \ "   | |     ::     ::      \\        / ",
 "       \ "   | |     :|     ||     \\ \\______/ ",
 "       \ "   | |     ||     ||      |\\  /  | ",
 "       \ "    \\|     ||     ||      |   / | \\ ",
 "       \ "     |     ||     ||      |  / /_\\ \\ ",
 "       \ "     | ___ || ___ ||      | /  /    \\ ",
 "       \ "      \\_-_/  \\_-_/ | ____ |/__/      \\ ",
 "       \ "                   _\\_--_/    \\      / ",
 "       \ "                  /____             / ",
 "       \ "                 /     \\           / ",
 "       \ "                 \\______\\_________/ ",
 "       \]


"let g:startify_enable_special
"let g:startify_list_order

"let g:startify_lists = [
"          \ { 'type': 'files',     'header': ['   MRU']            },
"          \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
"          \ { 'type': 'sessions',  'header': ['   Sessions']       },
"          \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
"          \ { 'type': 'commands',  'header': ['   Commands']       },
"          \ ]
"<

" use <tab> to trigger completion and navigate to the next complete item
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction




" inoremap <silent><expr> <Tab>
"      \ coc#pum#visible() ? coc#pum#next(1) :
"      \ CheckBackspace() ? "\<Tab>" :
"      \ coc#refresh()

"let g:startify_skiplist
"let g:startify_update_oldfiles

" statusbar using lualine
lua require('plugins')
"lua require('mini.starter').setup()
lua << END

vim.opt.termguicolors = true
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


--vim.opt.list = true
--vim.opt.listchars:append "space:⋅"
--vim.opt.listchars:append "eol:↴"
-- require("indent_blankline").setup {
--    space_char_blankline = " ",
--    show_current_context = true,
--    show_current_context_start = true,
--}

local custom_horizon = require'lualine.themes.horizon'
custom_horizon.insert.c.bg = 'c6577c'
custom_horizon.insert.c.fg = 'FFFFFF'

require('lualine').setup{
   options = { theme = custom_horizon }
}
END
