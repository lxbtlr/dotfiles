{
  config,
  lib,
  ...
}: {
  programs.nixvim = {
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    keymaps = [
      # Global
      # Default mode is "" which means normal-visual-op
      {
        mode = "n";
        key = "<SPACE>";
        action = "<Nop>";
        options.desc = "Disable SPACE in normal mode";
        options.noremap = true;
      }
      {
        mode = "n";
        key = "<leader>t";
        action = "<CMD>Neotree<CR>";
        options.desc = "Toggle Neotree";
      }
      {
        mode = "n";
        key = "<leader>fh";
        action = "<CMD>Telescope help_tags<CR>";
        options.desc = "Telescope help tags";
      }
      {
        mode = "n";
        key = "<leader><leader>";
        action = "<CMD>Telescope buffers<CR>";
        options.desc = "Telescope buffers";
      }
      {
        mode = "n";
        key = "<leader>fg";
        action = "<CMD>Telescope live_grep<CR>";
        options.desc = "Telescope Live Grep";
      }
      {
        mode = "n";
        key = "<leader>ff";
        action = "<CMD>Telescope find_files<CR>";
        options.desc = "Telescope Find Files";
      }
      {
        # Format file
        key = "<leader>fm";
        action = "<CMD>lua vim.lsp.buf.format()<CR>";
        options.desc = "Format the current buffer";
      }
      # Disable arrow keys
      {
        mode = ["n" "i"];
        key = "<Up>";
        action = "<Nop>";
        options = {
          silent = true;
          noremap = true;
          desc = "Disable Up arrow key";
        };
      }
      {
        mode = ["n" "i"];
        key = "<Down>";
        action = "<Nop>";
        options = {
          silent = true;
          noremap = true;
          desc = "Disable Down arrow key";
        };
      }
      {
        mode = ["n" "i"];
        key = "<Right>";
        action = "<Nop>";
        options = {
          silent = true;
          noremap = true;
          desc = "Disable Right arrow key";
        };
      }
      {
        mode = ["n" "i"];
        key = "<Left>";
        action = "<Nop>";
        options = {
          silent = true;
          noremap = true;
          desc = "Disable Left arrow key";
        };
      }
    ];
  };
}
