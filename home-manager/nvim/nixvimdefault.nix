{lib, inputs, ...}:
{
imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./nixvim_bufferline.nix
    ./nixvim_lualine.nix
    ./nixvim_blankline.nix
    ./nixvim_whichkey.nix
    ./nixvim_autocmd.nix
    ./keybinds.nix
    ./sets.nix
    ];


  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    viAlias = true;
    vimAlias = true;

    luaLoader.enable = true;

  };
};
