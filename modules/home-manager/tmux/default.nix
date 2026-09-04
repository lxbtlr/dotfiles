{pkgs, ...}:
# let
# import / define custom packages up here to be added to nix system below too
# {
#
#
# }
# in
{
  programs.tmux = {
    enable = true;
    clock24 = true;
    plugins = with pkgs.tmuxPlugins; [
      # TODO: break out custom plugin configs into separate files
      sensible
      yank
      sidebar
      vim-tmux-navigator
      #{
      #  plugin = fingers;
      #  extraConfig = ''
      #    unbind f
      #    set -g @fingers-key F
      #  '';
      #}
      #{
      #  plugin = tmux-thumbs;
      #  extraConfig = ''
      #    set -g @thumbs-key F
      #  '';
      #}
      {
        plugin = tmux-fzf;
        extraConfig = ''
          set -g @tmux-fzf F
        '';
      }
      #{
      #  plugin = catppuccin;
      #  extraConfig = ''
      #    set -g @catppuccin_flavor "mocha"

      #    set -g @catppuccin_window_default_text "#W" # use "#W" for application instead of directory
      #    set -g @catppuccin_window_format_directory_text "#W"
      #    set -g @catppuccin_window_default_fill "number"
      #    set -g @catppuccin_window_current_text "#W"
      #    set -ogq @catppuccin_window_text " #W"
      #   

      #    set -g @catppuccin_window_left_separator "█"
      #    set -g @catppuccin_window_right_separator "█ "
      #    set -g @catppuccin_window_number_position "right"
      #    set -g @catppuccin_window_middle_separator " █"


      #    set -g @catppuccin_window_current_fill "number"

      #    #set -ag status-right "#{E:@catppuccin_status_uptime}"
      #    
      #    set -g @catppuccin_status_modules_right "directory user host session"

      #    set -g @catppuccin_status_left_separator "█"
      #    set -g @catppuccin_status_right_separator "█"

      #    set -g @catppuccin_date_time_text "%Y-%m-%d %H:%M:%S"
      #  '';
      #}
    ];
    extraConfig = ''

      #set-option -g status-left ' #[fg=white]#P #S  #W  #[fg=white] '
      set-option -g status-right ' ' #'#H #[fg=white]%I:%M #[fg=white]%m.%d.%Y'
      
      #set-window-option -g window-status-current-style bg=black,fg=white
     
      set-window-option -g window-status-style "fg=#FFFFFF"
      set-window-option -g window-status-last-style "fg=#FFFFFF, bg=#4FBEFE,bold"
      setw -g window-status-format " #I:#W"
      setw -g window-status-current-format "#[bg=#6B50FF,fg=#FFFFFF,bold] #I:#W #[default]"
      setw -g window-status-format "#{?window_last_flag,#[bg=#2B55B3#,fg=#FFFFFF#,bold],#[fg=#FFFFFF#,bold]} #I:#W #[default]"
      
      set-option -g copy-mode-match-style "bg=#858392,fg=#201F26"
      set-option -g copy-mode-current-match-style "bg=yellow,fg=black,bold"

      #set-option -g pane-active-border-style fg=blue
      set-option -g status-position bottom
     

      set -g default-terminal "tmux-256color"
      set -as terminal-features ",xterm-ghostty:RGB"

      # set -g default-terminal "tmux-256color"
      # set -as terminal-features ",xterm-256color:RGB"

      set -g status-left-length 20
      set -sg escape-time 0
      set -g mouse on

      # Set Better default prefix
      unbind C-b
      set-option -g prefix C-Space
      bind-key C-Space send-prefix

      # Make splitting windows more intuitive

      unbind v
      unbind h
      unbind %    # Split vertically
      unbind '"'  # Split horizontally
      bind v split-window -h
      #-c "#{pane_current_path}"
      bind h split-window -v
      #-c "#{pane_current_path}"

      # Move like Vim

      bind -n C-h select-pane -L
      bind -n C-j select-pane -D
      bind -n C-k select-pane -U
      bind -n C-l select-pane -R

      set -g history-limit 100000

      # Window settings

      set -g renumber-windows on
      set -g base-index 1
      set-window-option -g pane-base-index 1

      unbind n    #DEFAULT KEY: Move to next window
      unbind w    #DEFAULT KEY: change current window interactively

      bind n command-prompt "rename-window '%%'"
      bind w new-window
      #-c "#{pane_current_path}"

      ## vim-esk window movement
      bind -n M-j previous-window
      bind -n M-k next-window

      # Making copy mode vim-like
      set-window-option -g mode-keys vi

      unbind -T copy-mode-vi Space; #Default for begin-selection
      unbind -T copy-mode-vi Enter; #Default for copy-selection

      bind-key -T copy-mode-vi 'v' send-keys -X begin-selection
      bind-key -T copy-mode-vi 'y' send-keys -X copy-pipe-and-cancel "wl-copy"
      bind C-p run "wl-paste --no-newline | tmux load-buffer - ; tmux paste-buffer"

### CHARMTONE — raw values

# Status bar base — BBQ ground, Smoke text
set-option -g status-style bg=#2D2C36,fg=#BFBCC8

# Inactive windows: plain, recessed
set-window-option -g window-status-style bg=default,fg=#858392

# Active window: Charple fill, white text
set-window-option -g window-status-current-style bg=#6B50FF,fg=#FFFFFF,bold

# Last window: subtle nod, no fill
set-window-option -g window-status-last-style fg=#4FBEFE

# Activity alert: Mustard
set-window-option -g window-status-activity-style bg=#F5EF34,fg=#2D2C36

# Bell: Bengal, distinct from the Charple active window
set-window-option -g window-status-bell-style bg=#FF6E63,fg=#2D2C36,bold

# Pane borders — Squid recedes, Charple marks focus
set-option -g pane-border-style fg=#858392
set-option -g pane-active-border-style fg=#6B50FF

# Messages and prompt
set-option -g message-style bg=#F5EF34,fg=#2D2C36,bold
set-option -g message-command-style bg=#00A4FF,fg=#2D2C36,bold

# Copy mode selection and search
#set-window-option -g mode-style bg=#3A3943,fg=#F7F6FB
#set-option -g copy-mode-match-style bg=#858392,fg=#2D2C36
#set-option -g copy-mode-current-match-style bg=#F5EF34,fg=#2D2C36

# Pane number display
set-option -g display-panes-active-colour "#00A4FF"
set-option -g display-panes-colour "#858392"

# Clock
set-window-option -g clock-mode-colour "#10B1AE"


##      ### OXOCARBON
##
##      # Set the default statusbar color
#      set-option -g status-style fg=white,bg=black # Dark background, light text
##      
##      # Set the default window title colors
#      set-window-option -g window-status-style bg=colour6,fg=colour0 # Light blue background, dark text
##      
##      # Set the default window with an activity alert
#      set-window-option -g window-status-activity-style bg=colour0,fg=colour7 # Dark background, light text
##      
##      # Active window title colors
#      set-window-option -g window-status-current-style bg=colour1,fg=colour0 # Dark red background, light text
##      
##      # Pane border colors
#      set-option -g pane-active-border-style fg=colour6 # Light blue
#      set-option -g pane-border-style fg=colour0 # Dark text
##      
##      # Message info
#      set-option -g message-style bg=colour8,fg=colour15 # Light background, light text
##      
##      # Writing commands inactive
##      set-option -g message-command-style bg=colour6,fg=colour15 # Light background, light text
##      
##      # Pane number display
#      set-option -g display-panes-active-colour colour6 # Light blue
#      set-option -g display-panes-colour colour0 # Dark text
##      
##      # Clock
##      set-window-option -g clock-mode-colour colour7 # Blue
##      
##      # Bell
#      set-window-option -g window-status-bell-style bg=colour9,fg=colour15 # Red background, light text
#      
#      # Status bar settings
#      set-option -g status-justify "left"
#      set-option -g status-left-style none
#      set-option -g status-left-length "80"
#      set-option -g status-right-style none
#      set-option -g status-right-length "80"
#      set-window-option -g window-status-separator ""
#      
#      # Customize the status-left and status-right sections to your preference
#      set-option -g status-left "#[bg=colour9,fg=colour0] #S #[bg=colour3,fg=colour9,nobold,noitalics,nounderscore]"
#      set-option -g status-right "#[bg=colour3,fg=colour4 nobold, nounderscore, noitalics]#[bg=colour4,fg=colour6] %Y-%m-%d  %H:%M #[bg=colour4,fg=colour9,nobold,noitalics,nounderscore]#[bg=colour9,fg=colour3] #h "
#      
#      # Customize the window status formats
#      #set-window-option -g window-status-current-format "#[bg=colour3,fg=colour9,nobold,noitalics,nounderscore]#[bg=colour3,fg=colour4] #I #[bg=colour3,fg=colour4,bold] #W #{?window_zoomed_flag,*Z,} #[bg=colour9,fg=colour3,nobold,noitalics,nounderscore]"
#      #set-window-option -g window-status-format "#[bg=colour9,fg=colour3,noitalics]#[bg=colour9,fg=colour0] #I #[bg=colour9,fg=colour0] #W #[bg=colour3,fg=colour9,noitalics]"
#      
#      # vim: set ft=tmux tw=0 nowrap:

      # Fix NVIM  / tmux cursor problem
      set -g -a terminal-overrides ',*:Ss=\E[%p1%d q:Se=\E[2 q'
      bind r source-file ~/.config/tmux/tmux.conf
    '';
  };
}
