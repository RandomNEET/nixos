{ ... }:
{
  programs.nixvim = {
    plugins.blink-cmp = {
      enable = true;
      settings = {
        keymap = {
          preset = "super-tab";
        };
        sources = {
          providers = {
            copilot = {
              async = true;
              module = "blink-cmp-copilot";
              name = "copilot";
              score_offset = 100;
            };
          };
          default = [
            "lsp"
            "path"
            "buffer"
            "copilot"
          ];
        };
      };
    };
    plugins.blink-cmp-copilot.enable = true;
  };
}
