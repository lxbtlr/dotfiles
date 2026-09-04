{pkgs, ...}: {
  services.mako = {
    enable = false;
    settings = {
      background-color = "#222436";
      border-color = "#1e1e2e";
      default-timeout = 10000;
    };
};

}
