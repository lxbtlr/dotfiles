
{pkgs, config, root, ...}:

{
  programs.neovim = {
  
    plugins = with pkgs.vimPlugins; [
      hydra-nvim
      gitsigns-nvim
    ];

    extraLuaConfig = ''
      local Hydra = require("hydra")
      Hydra({
         name = 'Side scroll',
         mode = 'n',
         body = 'z',
         heads = {
            { 'h', '5zh' },
            { 'l', '5zl', { desc = '←/→' } },
            { 'H', 'zH' },
            { 'L', 'zL', { desc = 'half screen ←/→' } },
         }
      })

      local gitsigns = require('gitsigns').setup()

      local hint = [[
       _J_: next hunk   _s_: stage hunk        _d_: show deleted   _b_: blame line
       _K_: prev hunk   _u_: undo last stage   _p_: preview hunk   _B_: blame show full 
       ^ ^              _S_: stage buffer      ^ ^                 _/_: show base file
       ^
       ^ ^              _<Enter>_: Neogit              _q_: exit
      ]]
      Hydra({
         name = 'Git',
         hint = hint,
         config = {
            buffer = bufnr,
            color = 'red',
            invoke_on_body = true,
            hint = {
               border = 'rounded'
            },
            on_key = function() vim.wait(50) end,
            on_enter = function()
               vim.cmd 'mkview'
               vim.cmd 'silent! %foldopen!'
               gitsigns.toggle_signs(true)
               gitsigns.toggle_linehl(true)
            end,
            on_exit = function()
               local cursor_pos = vim.api.nvim_win_get_cursor(0)
               vim.cmd 'loadview'
               vim.api.nvim_win_set_cursor(0, cursor_pos)
               vim.cmd 'normal zv'
               gitsigns.toggle_signs(false)
               gitsigns.toggle_linehl(false)
               gitsigns.toggle_deleted(false)
            end,
         },
         mode = {'n','x'},
         body = '<leader>g',
         heads = {
            { 'J',
               function()
                  if vim.wo.diff then return ']c' end
                  vim.schedule(function() gitsigns.next_hunk() end)
                  return '<Ignore>'
               end,
               { expr = true, desc = 'next hunk' } },
            { 'K',
               function()
                  if vim.wo.diff then return '[c' end
                  vim.schedule(function() gitsigns.prev_hunk() end)
                  return '<Ignore>'
               end,
               { expr = true, desc = 'prev hunk' } },
            { 's',
               function()
                  local mode = vim.api.nvim_get_mode().mode:sub(1,1)
                  if mode == 'V' then -- visual-line mode
                     local esc = vim.api.nvim_replace_termcodes('<Esc>', true, true, true)
                     vim.api.nvim_feedkeys(esc, 'x', false) -- exit visual mode
                     vim.cmd("'<,'>Gitsigns stage_hunk")
                  else
                     vim.cmd("Gitsigns stage_hunk")
                  end
               end,
               { desc = 'stage hunk' } },
            { 'u', gitsigns.undo_stage_hunk, { desc = 'undo last stage' } },
            { 'S', gitsigns.stage_buffer, { desc = 'stage buffer' } },
            { 'p', gitsigns.preview_hunk, { desc = 'preview hunk' } },
            { 'd', gitsigns.toggle_deleted, { nowait = true, desc = 'toggle deleted' } },
            { 'b', gitsigns.blame_line, { desc = 'blame' } },
            { 'B', function() gitsigns.blame_line{ full = true } end, { desc = 'blame show full' } },
            { '/', gitsigns.show, { exit = true, desc = 'show base file' } }, -- show the base of the file
            { '<Enter>', function() vim.cmd('Neogit') end, { exit = true, desc = 'Neogit' } },
            { 'q', nil, { exit = true, nowait = true, desc = 'exit' } },
         }
      })
    '';
  };
}
