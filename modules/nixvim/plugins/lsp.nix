{ opts, ... }:
{
  programs.nixvim = {
    plugins = {
      lsp = {
        enable = opts.nixvim.lsp.enable;
        servers = {
          lua_ls.enable = true;
          yamlls.enable = true;
          nil_ls.enable = true;
          marksman.enable = true;
          pyright.enable = true;
          bashls.enable = true;
          jsonls.enable = true;
          ts_ls.enable = true;
          html.enable = true;
          volar.enable = true;
        };
        keymaps = {
          silent = true;
          diagnostic = {
            "<leader>k" = "goto_prev";
            "<leader>j" = "goto_next";
          };
          lspBuf = {
            "gd" = "definition";
            "gD" = "declaration";
            "gi" = "implementation";
            "gr" = "references";
            "gt" = "type_definition";
            "K" = "hover";

            "<C-k>" = "signature_help";

            "<leader>ca" = "code_action";
            "<leader>rn" = "rename";
            "<leader>wa" = "add_workspace_folder";
            "<leader>wr" = "remove_workspace_folder";
          };
        };
      };
    };
  };
}
