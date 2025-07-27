{ ... }:
{
  programs.nixvim = {
    plugins.copilot-lua = {
      enable = true;
      settings = {
        filetypes.markdown = true;
        suggestion = {
          enabled = false;
          auto_trigger = false;
        };
      };
    };
  };
}
