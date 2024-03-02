# bash nix config
{pkgs, ...}: {
  programs.bash = {
    enable = true;

    enableCompletion = true;
    bashrcExtra = ''
      export DIRENV_LOG_FORMAT="$(printf "\033[2mdirenv: %%s\033[0m")"
      eval "$(direnv hook bash)"
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
    '';
    # interactiveShellInit = (builtins.readFile ./bash/bashrc);
    shellAliases = {
      pls = "sudo";
      ls = "eza --icons -F -H --group-directories-first --git -1";
      whereami = "pwd";
      vd = "visidata";
      z = "zoxide";
      za = "zoxide add";
      zr = "zoxide remove";
      tx = "tmuxinator";
      rebuild2 = "sudo nixos-rebuild switch --flake $(pwd)#lxbtlr";
      rebuild = "sudo nixos-rebuild switch --flake /home/lxbtlr/dotfiles/#lxbtlr";
      py = "nix-shell /home/lxbtlr/dotfiles/shell.nix";
      clear = "clear; neofetch";
      gc = "nix-collect-garbage -d";
      q = "qimgv";
      #mkjp="$$; cd $_";
      hist = "history | fzf --tac";
      #TODO: fix
      #repro="sudo nixos-rebuild switch -I nixos-config=configuration.nix#lxbtlr";
    };
    initExtra = ''
      howmany ()
      {
        ls -1 $1 | wc -l
      }
      png2mp4 ()
      {
        # convert all pngs in dir to video
        ffmpeg -pattern_type glob -framerate $1/1.2 -i "$2/*.png" -vcodec mpeg4 -pix_fmt yuv420p $3.mp4
      }

      mkjp () {
          mkdir "$1" && z "$1"
      }

      _direnv_hook() {
        eval "$(direnv export bash 2> >(egrep -v -e '^....direnv: export' >&2))"
      };

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
