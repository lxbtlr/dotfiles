# TODO:
- add more keymaps to xremap
    - [x] capslock -> ctrl
- move xremap out of `cuttlefish/configuration.nix`
- flesh out niri implementation
    - [ ] make sure that it does not break KDE setup
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
 - modules/
     - home-manager/
        - where package modules (and their confs) are
     - nixos/
        - where nixos modules are (kde plasma, hyprland, etc)
 - templates/
    - WIP : stores template .nix / project files that can easily be copied into another dir, should be generic
 flake.lock*
 flake.nix*
 README.md
```



