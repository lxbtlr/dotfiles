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
          caps lmet
        )
        
        (deflayer base
          lctl
          (tap-hold 200 200 f13 lmet)
         )
      '';
    };
  };
  systemd.services.kanata-internal.serviceConfig = {
    Restart = "always";
    RestartSec = 2;
  };
}
