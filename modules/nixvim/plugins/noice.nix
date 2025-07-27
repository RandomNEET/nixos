{ ... }:
{
  programs.nixvim = {
    plugins = {
      noice = {
        enable = true;
        settings = {
          notify = {
            enabled = true;
          };
          presets = {
            bottom_search = false;
            command_palette = true;
            inc_rename = false;
            long_message_to_split = false;
            lsp_doc_border = false;
          };
          messages = {
            enabled = true; # Adds a padding-bottom to neovim statusline when set to false for some reason (untested)
          };
          lsp = {
            message = {
              enabled = true;
            };
            progress = {
              enabled = false;
              view = "mini";
            };
            override = {
              "vim.lsp.util.convert_input_to_markdown_lines" = true;
              "vim.lsp.util.stylize_markdown" = true;
              "cmp.entry.get_documentation" = true;
            };
          };
          popupmenu = {
            enabled = true;
            backend = "nui";
          };
          format = {
            filter = {
              pattern = [
                ":%s*%%s*s:%s*"
                ":%s*%%s*s!%s*"
                ":%s*%%s*s/%s*"
                "%s*s:%s*"
                ":%s*s!%s*"
                ":%s*s/%s*"
              ];
              icon = "";
              lang = "regex";
            };
            replace = {
              pattern = [
                ":%s*%%s*s:%w*:%s*"
                ":%s*%%s*s!%w*!%s*"
                ":%s*%%s*s/%w*/%s*"
                "%s*s:%w*:%s*"
                ":%s*s!%w*!%s*"
                ":%s*s/%w*/%s*"
              ];
              icon = "󱞪";
              lang = "regex";
            };
          };
          #presets = {
          #    bottom_search = true;
          #    command_palette = true;
          #    lsp_doc_border = true;
          #};
        };
      };
    };
  };
}
