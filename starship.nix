# starship.nix
# for all my starship configuration needs
{ pkgs, lib, ... }:

with lib;
with builtins;

let
  isRustFile = path: type:
    hasSuffix ".rs" path && type == "regular" && path != "mod.rs";
  mergeAllAttrSets = attrsSets:
    foldl' (recursiveUpdate) {} attrsSets;
  disableModules = isDisabled: modules:
    mergeAllAttrSets (map (mod: { "${mod}".disabled = isDisabled; }) modules);

  starshipPackage = pkgs.starship;
  promptOrder = [ 
      "username"
      "directory"
      "git_branch"
      "git_commit"
      "git_state"
      "git_metrics"
      "git_status"
      "nix_shell"
      "cmd_duration"
      "rust"
      "python"
      "character"
  ];
  promptFormat = concatStrings (map (s: "\$${s}") promptOrder);
  modulesSources = readDir "${starshipPackage.src}/src/modules";
  enabledModules = disableModules false promptOrder; # <== enabled all modules used in the prompt are enabled
  disabledModules = pipe modulesSources [            # <== from starship's sources...
    (filterAttrs isRustFile)                         # <== keep only Rust files...
    attrNames                                        # <== get the filenames...
    (map (removeSuffix ".rs"))                       # <== remove Rust source extension...
    (subtractLists promptOrder)                      # <== do not disable modules used in the prompt...
    (disableModules true)                            # <== and finally build the configuration
  ];
in
{
  programs.starship = {
    package = starshipPackage;
    enable = true;
    enableBashIntegration = true;
    settings = mergeAllAttrSets [
      enabledModules
      disabledModules
      {
        format = promptFormat;
        directory = {
          format  = "[$path ](bg:#ffe97b fg:black)";
          truncation_length = 4;
          truncation_symbol = "…/";
        };
        git_branch = {
          format = "[ $symbol$branch ](bg:white fg:black)";
          truncation_length = 30;
        };
        character= {
          format = "\n$symbol ";
#          success_symbol="[>](bold white)[>](bold purple)[>](bold green)";
#          #success_symbol = "[➜](bold green) ";
#          error_symbol = "[ ✗ ](bold red) ";
        };

        username = {
          format ="[ $user](bg:#42be65 fg:black)[░▒▓█](fg:#ffe97b bg:#42be65)";
          style_root = "bg:white bold fg:black"; 
          style_user = "fg:white bold bg:black"; 
          disabled = false;
          show_always = true;
	};

      }
    ];
  };
}

