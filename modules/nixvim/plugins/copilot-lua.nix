{ opts, ... }:
{
  programs.nixvim = {
    plugins.copilot-lua = {
      enable = opts.nixvim.copilot.enable;
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
