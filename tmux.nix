{pkgs, ...}:
{   
  programs.tmux = {
    clock24 = true;
    extraConfig = '' 
        unbind C-b
        set -g prefix C-Space
        unbind r
        bind r source-file ~/.tmux.conf \; display "Reloaded ~/.tmux.conf"
        unbind v
        unbind h
        
        unbind % # Split vertically
        unbind '"' # Split horizontally
        
        bind v split-window -h -c "#{pane_current_path}"
        bind h split-window -v -c "#{pane_current_path}"
        unbind n  #DEFAULT KEY: Move to next window
        unbind w  #DEFAULT KEY: change current window interactively
        
        bind n command-prompt "rename-window '%%'"
        bind w new-window -c "#{pane_current_path}"
        '';
  };
}
