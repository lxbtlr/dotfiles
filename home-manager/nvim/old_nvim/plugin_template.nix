{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = /*ADD PLUGIN NAME HERE*/;
      type = "lua";
      config = /*ADD CONFIG HERE */''

      '';
    }
  ];
}
