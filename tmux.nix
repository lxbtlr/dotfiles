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
    enable =true;
    clock24 = true;
    plugins = with pkgs.tmuxPlugins; [
        sensible
        yank
        {
          plugin = fingers;
          extraConfig = ''

          '';
        }
        {
          plugin = tmux-thumbs;
          extraConfig = ''

          '';
        }
        {
          plugin = catppuccin;
          extraConfig = ''
          set -g @catppuccin_window_right_separator "█ "
          set -g @catppuccin_window_number_position "right"
          set -g @catppuccin_window_middle_separator " | "
          set -g @catppuccin_window_current_text "#W"   # "#{b:pane_current_path}" # use "#W" for application instead of directory
          set -g @catppuccin_window_default_fill "none"
      
          set -g @catppuccin_window_current_fill "all"
      
          set -g @catppuccin_status_modules_right "application session user host date_time"
          set -g @catppuccin_status_left_separator "█"
          set -g @catppuccin_status_right_separator "█"
      
          set -g @catppuccin_date_time_text "%Y-%m-%d %H:%M:%S"
          '';
        }

      ];
    extraConfig = '' 

        #set-option -g status-left ' #[fg=white]#P #S  #W  #[fg=white] '
        #set-option -g status-right ' ' #'#H #[fg=black]%I:%M #[fg=black]%m.%d.%Y'

        set-option -g pane-active-border-style fg=blue
        set-option -g status-position top       
        set -g default-terminal "screen-256color"

        # Set Better default prefix
        unbind C-b
        set-option -g prefix C-Space
        bind-key C-Space send-prefix
        
        # Make splitting windows more intuitive

        unbind v
        unbind h
        unbind %    # Split vertically
        unbind '"'  # Split horizontally
        bind v split-window -h -c "#{pane_current_path}"
        bind h split-window -v -c "#{pane_current_path}"
        
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
        bind w new-window -c "#{pane_current_path}"
        
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
        
        # Fix NVIM  / tmux cursor problem
        set -g -a terminal-overrides ',*:Ss=\E[%p1%d q:Se=\E[2 q'        
        
        '';
  };
}
