{
  # Import all your configuration modules here
  imports = [
    ./bufferline.nix
  ];

  colorschemes.gruvbox.enable = true;

  plugins = {
    lualine.enable = true;

    telescope.enable = true;

    oil.enable = true;

    treesitter.enable = true;
  };

  plugins.lsp = {
    enable = true;
    servers = {

      rust-analyzer.enable = true;

      pylyzer.enable = true;

      java-language-server.enable = true;
}
