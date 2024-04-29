
  # Import all your configuration modules here
{self, ...}: {
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
	
#	plugins.lsp.servers.rust-analyzer.installCargo = true;
#	plugins.lsp.servers.rust-analyzer.installRustc = true;

     # jedi-language-server.enable  = true;

      java-language-server.enable = true;
    };
  };
}
