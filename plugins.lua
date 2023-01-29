local vim = vim
local execute = vim.api.nvim_command
local fn = vim.fn
-- ensure that packer is installed
local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
    execute 'packadd packer.nvim'
end
vim.cmd('packadd packer.nvim')
local packer = require'packer'
local util = require'packer.util'





packer.init({
  package_root = util.join_paths(vim.fn.stdpath('data'), 'site', 'pack')
})
--- startup and add configure plugins
packer.startup(function()
  local use = use
  -- add you plugins here like:

  -- DEBUGGER for C
  use 'mfussenegger/nvim-dap'
  -- CMAKE TOOLS for C
  use 'Civitasv/cmake-tools.nvim'
  --use {'goolord/alpha-nvim'}
  use 'nvim-tree/nvim-web-devicons'
  use 'neovim/nvim-lspconfig'
  use {'nyoom-engineering/oxocarbon.nvim'}
  use {'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons'}
  use {"folke/which-key.nvim"}

end)
--config = function ()
--  require'alpha'.setup(require'alpha.themes.startify'.config)
--end

local dap = require('dap')
dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = '/tmp/cpptools-linux-aarch64/extension/debugAdapters/bin/OpenDebugAD7', 
}
dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopAtEntry = true,
    setupCommands = {  
        { 
          text = '-enable-pretty-printing',
          description =  'enable pretty printing',
          ignoreFailures = false 
        },
    },
  },
  {
    name = 'Attach to gdbserver :1234',
    type = 'cppdbg',
    request = 'launch',
    MIMode = 'gdb',
    miDebuggerServerAddress = 'localhost:1234',
    miDebuggerPath = '/usr/bin/gdb',
    cwd = '${workspaceFolder}',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
  },
}

vim.o.timeout = true
vim.o.timeoutlen = 300
require("which-key").setup {}
vim.opt.background = "dark" -- set this to dark or light
vim.cmd("colorscheme oxocarbon")
--vim.opt.termguicolors = true
require("bufferline").setup{}

