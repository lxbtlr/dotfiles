{
  programs.nixvim.plugins.conform-nvim = {
    enable = true;
    #format_on_save = {
    #  lsp_fallback = true;
    #  timeout_ms = 500;
    #};
    settings.notify_on_error = true;
    settings.formatters_by_ft = {
      liquidsoap = ["liquidsoap-prettier"];
      html = [["prettierd" "prettier"]];
      css = [["prettierd" "prettier"]];
      javascript = [["prettierd" "prettier"]];
      javascriptreact = [["prettierd" "prettier"]];
      typescript = [["prettierd" "prettier"]];
      typescriptreact = [["prettierd" "prettier"]];
      python = ["black"];
      lua = ["stylua"];
      nix = ["alejandra"];
      markdown = [["prettierd" "prettier"]];
      yaml = ["yamllint" "yamlfmt"];
    };
  };
}
