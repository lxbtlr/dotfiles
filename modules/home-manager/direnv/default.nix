# direnv.nix
{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };
  programs.bash = {
    bashrcExtra = lib.mkBefore ''
      export DIRENV_LOG_FORMAT="$(printf "\033[2mdirenv: %%s\033[0m")"
      eval "$(direnv hook bash)"
    '';
  };
}
