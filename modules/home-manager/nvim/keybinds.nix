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

      # Here are my telekasten note taking keymaps (WIP)
      #
      # panel : brings up the command palette
      {
        mode = "n";
        key = "<SPACE>";
        action = "<Nop>";
        options.desc = "Disable SPACE in normal mode";
        options.noremap = true;
      }
      # {
      #   mode = "n";
      #   key = "<leader>tp";
      #   action = "<CMD>Telekasten panel<CR>";
      #   options.desc = "brings up the command palette";
      # }
      # # find_notes : Find notes by title (filename)
      # {
      #   mode = "n";
      #   key = "<leader>fn";
      #   action = "<CMD>Telekasten find_notes<CR>";
      #   options.desc = "Find notes by title (filename)";
      # }

      # # show_tags : brings up the tag list. From there you can select a tag to search for tagged notes - or yank or insert the tag
      # {
      #   mode = "n";
      #   key = "<leader>st";
      #   action = "<CMD>Telekasten show_tags<CR>";
      #   options.desc = "brings up the tag list. From there you can select a tag to search for tagged notes - or yank or insert the tag";
      # }
      # # find_daily_notes : Find daily notes by title (date)
      # # search_notes : Search (grep) in all notes
      # {
      #   mode = "n";
      #   key = "<leader>gn";
      #   action = "<CMD>Telekasten search_notes<CR>";
      #   options.desc = "Search in all notes (grep)";
      # }
      # # insert_link : Insert a link to a note
      # {
      #   mode = "v";
      #   key = "<leader>ii";
      #   action = "<CMD>Telekasten insert_link<CR>";
      #   options.desc = "Instert note link below cursor";
      # }
      # # follow_link : Follow the link under the cursor
      # {
      #   mode = "n";
      #   key = "<ENTER>";
      #   action = "<CMD>Telekasten follow_link<CR>";
      #   options.desc = "Follow link under cursor";
      # }
      # # goto_today : Open today's daily note
      # # new_note : Create a new note, prompts for title
      # {
      #   mode = "n";
      #   key = "<leader><ENTER>";
      #   action = "<CMD>Telekasten new_note<CR>";
      #   options.desc = "Follow link under cursor";
      # }
      # # goto_thisweek : Open this week's weekly note
      # # find_weekly_notes : Find weekly notes by title (calendar week)
      # # yank_notelink : Yank a link to the currently open note
      # {
      #   mode = "n";
      #   key = "<leader>ny";
      #   action = "<CMD>Telekasten yank_notelink<CR>";
      #   options.desc = "Yank a link to the current open note";
      # }
      # # new_templated_note : create a new note by template, prompts for title and template
      # {
      #   mode = "n";
      #   key = "<leader>nt";
      #   action = "<CMD>Telekasten new_templated_note<CR>";
      #   options.desc = "create a new note by template, prompts for title and template";
      # }
      # # show_calendar : Show the calendar
      # # paste_img_and_link : Paste an image from the clipboard into a file and inserts a link to it
      # # toggle_todo : Toggle - [ ] todo status of a line
      # # show_backlinks : Show all notes linking to the current one
      # {
      #   mode = "n";
      #   key = "<leader>l";
      #   action = "<CMD>Telekasten show_backlinks<CR>";
      #   options.desc = "Backlinks??";
      # }
      # # find_friends : Show all notes linking to the link under the cursor
      # {
      #   mode = "n";
      #   key = "<leader>fn";
      #   action = "<CMD>Telekasten search_notes<CR>";
      #   options.desc = "Show all notes linking to the link under the cursor";
      # }
      # # insert_img_link : Browse images / media files and insert a link to the selected one
      # # preview_img : preview image under the cursor
      # # browse_media : Browse images / media files
      # # rename_note : Rename current note and update the links pointing to it
      # # switch_vault : switch the vault. Brings up a picker. See the vaults config option for more.
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
      {
        mode = "n";
        key = "<leader>co";
        action = "<cmd>Lspsaga outline<CR>";
        options = {
          desc = "Outline";
          silent = true;
        };
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
