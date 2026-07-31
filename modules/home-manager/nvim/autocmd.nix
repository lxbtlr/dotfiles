{
  programs.nixvim.autoCmd = [
    # Enable spellcheck for some filetypes
    {
      event = "FileType";
      pattern = [
        "tex"
        "latex"
        "markdown"
      ];
      command = "setlocal spell spelllang=en";
    }
   {
    command = "!quarto render 2> /dev/null";
    event = [
      "BufWritePost"
    ];
    pattern = [
      "*.qmd"
    ];
   }
  ];
}
