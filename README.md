# TODO:
- move common config lines to `common` folder
- add templates for different languages
  - add direnv templates too
- change `rebuild` script so it appropriately chooses the correct hostname to rebuild on _any_ machine
- add more keymaps to xremap
    - [x] capslock -> ctrl
    - [ ]
- move xremap out of `cuttlefish/configuration.nix`

# Notes to self:
- When setting up a new machine:
    - create separate folder in `/nixos/<mach-name>`
    - add entry to flake.nix
    - copy / make your configuration.nix (in `/nixos/<mach-name>`)
    - use `nixos-generate-config` to create hardware-conf for new mach & add it to the folder

- update a specific flake:
    ```nix
    nix flake lock --update-input <flake-name>
    ```

# File Structure:
```
./
 home-manager/
    - currently, adv configs for packages (themes, binds, etc), and stock packages
    - ought to be where user specific configs live (home.nix?, imports from modules)
 modules/
     home-manager/
        - currently unused, but ought to be where package modules (and their confs) are
     nixos/
        - currently unused, but ought to be where nixos modules are (kde plasma, hyprland, etc)
 nixos/
    - Currently where machine specs (config, hw-conf) are stored, imports from modules
 overlays/
    - unused, but for overlays (specific c toolchain etc)
 pkgs/
    - pkg import, may be worth using as a staging area for new flakes
 templates/
    - stores template .nix / project files that can easily be copied into another dir, should be generic
 flake.lock*
 flake.nix*
 README.md
```



