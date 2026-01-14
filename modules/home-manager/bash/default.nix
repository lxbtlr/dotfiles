# bash nix config
{pkgs, ...}: {
  programs.bash = {
    enable = true;

    enableCompletion = true;
    bashrcExtra = ''
      export OPENROUTER_API_KEY=$(cat ~/dotfiles/modules/home-manager/bash/openrouter.secret)
      export DIRENV_LOG_FORMAT="$(printf "\033[2mdirenv: %%s\033[0m")"
      eval "$(direnv hook bash)"
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
    '';
    # interactiveShellInit = (builtins.readFile ./bash/bashrc);
    sessionVariables = {
      EDITOR = "nvim";  
    };
    shellAliases = {
# make slack work like it should on wayland
      slack = "NIXOS_OZONE_WL=1 slack";
      pls = "sudo";
      ls = "eza --icons -F -H --group-directories-first --git -1";
      whereami = "pwd";
      vd = "visidata";
      z = "zoxide";
      za = "zoxide add";
      zr = "zoxide remove";
      tx = "tmuxinator";
      ngit = "nvim +Neogit";

      rst_nw = "pls modprobe -r mt7921e && pls modprobe mt7921e";

      intel = "less +34266g ~/Documents/intel_arch_x86.pdf";
      amd = "less +68030g ~/Documents/amd64_1_2_3_4_5.pdf";
      arm = "less +101645g ~/Documents/armv8.pdf";

      # NOTE: tmuxinator envs to jump into
      jumpbarrier = "tmuxinator jumpbarrier";
      quantum = "tmuxinator qcs";
      cronus = "tmuxinator qcs";
      notebook = "ssh -L 8080:localhost:8080 dubliner";
      
      #NOTE: this should only work in dotfiles repo for now, consider adding a env var for the dotfile loc
      rebuild="sudo nixos-rebuild switch --flake .#$(hostname) --option eval-cache false --show-trace";

      clear = "clear";
      gc = "nix-collect-garbage -d";
      q = "qimgv";

      hist = "history | fzf --tac";
      #TODO: fix
      #repro="sudo nixos-rebuild switch -I nixos-config=configuration.nix#lxbtlr";
    };
    initExtra = ''
      bind 'TAB:menu-complete'
      bind 'set show-all-if-ambiguous on'
      howmany ()
      {
        ls -1 $1 | wc -l
      }
      png2mp4 ()
      {
        # convert all pngs in dir to video
        ffmpeg -pattern_type glob -framerate $1/1.2 -i "$2/*.png" -vcodec mpeg4 -pix_fmt yuv420p $3.mp4
      }

      test -r /home/lxbtlr/.opam/opam-init/init.sh && . /home/lxbtlr/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true

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
      export _ZO_DOCTOR=0
      eval "$(direnv hook bash)"
      eval "$(zoxide init bash)"
      eval "$(starship init bash)"
    '';
  };
}
