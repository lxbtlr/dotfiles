# bash nix config
{pkgs, ...}:
{
  programs.bash = {
    enable = true;

    enableCompletion = true;
    bashrcExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
    '';
    # interactiveShellInit = (builtins.readFile ./bash/bashrc);
    shellAliases = {
      pls = "sudo";
      ls="exa --icons -F -H --group-directories-first --git -1";  
      z = "zoxide";
      za = "zoxide add" ;
      zr = "zoxide remove";
      rebuild="sudo nixos-rebuild switch --flake $(pwd)#lxbtlr";
      #rebuild = "sudo nixos-rebuild switch --flake /etc/nixos#lxbtlr";
      hist="history | fzf --tac";
      #TODO: fix me 
      #repro="sudo nixos-rebuild switch -I nixos-config=configuration.nix#lxbtlr";
      };
    initExtra = ''
      # # ex - archive extractor
      # # usage: ex \<file\>
      ex ()
      {
        if [ -f $1 ] ; then
          case $1 in
            *.tar.bz2)   tar xjf $1   ;;
            *.tar.gz)    tar xzf $1   ;;
            *.bz2)       bunzip2 $1   ;;
            *.rar)       unrar x $1     ;;
            *.gz)        gunzip $1    ;;
            *.tar)       tar xf $1    ;;
            *.tbz2)      tar xjf $1   ;;
            *.tgz)       tar xzf $1   ;;
            *.zip)       unzip $1     ;;
            *.Z)         uncompress $1;;
            *.7z)        7z x $1      ;;
            *)           echo "'$1' cannot be extracted via ex()" ;;
          esac
        else
          echo "'$1' is not a valid file"
        fi
      }
      eval "$(direnv hook bash)"    
      eval "$(zoxide init bash)"
      eval "$(starship init bash)"    
      '';
    
  };
}

