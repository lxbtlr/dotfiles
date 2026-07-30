{
  services.kanata = {
    enable=true;
    keyboards.internal = {
      devices = [];
      extraDefCfg = "process-unmapped-keys yes";
      # Ported from kanata/kanata.kbd:
      #   CapsLock -> Esc on tap, Ctrl on hold
      #   Esc      -> CapsLock
      config = ''
        (defsrc
          caps esc
        )

        (deflayer base
          (tap-hold 200 200 esc lctl) caps
        )
      '';
    };
  };
}
