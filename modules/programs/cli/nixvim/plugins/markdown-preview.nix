{
  config,
  lib,
  opts,
  ...
}:
{
  programs.nixvim = {
    keymaps = lib.mkIf ((opts.browser or "") != "" && config.programs.${opts.browser}.enable) [
      {
        mode = [
          "n"
        ];
        key = "<leader>md";
        action = "<cmd>MarkdownPreviewToggle<cr>";
        options = {
          desc = "Open markdown previrew in browser";
        };
      }
    ];
    plugins.markdown-preview = {
      enable = (opts.browser or "") != "" && config.programs.${opts.browser}.enable;
      settings = {
        auto_close = 1;
        # auto_start = true;
        page_title = "「\${name}」";
        port = "8080";
        preview_options = {
          disable_filename = 1;
          disable_sync_scroll = 1;
          sync_scroll_type = "middle";
        };
        theme = "dark";
      };
    };
  };
}
