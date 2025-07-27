{ ... }:
{
  programs.nixvim = {
    keymaps = [
      {
        mode = "n";
        key = "<leader>fm";
        action = "<CMD>lua require('conform').format({ aync = true, lsp_fallback = true })<CR>";
        options = {
          desc = "Format buffer";
        };
      }
    ];
    plugins.conform-nvim = {
      enable = true;
      settings = {
        formatters_by_ft = {
          # asm = [ "asmfmt" ];
          # c = [ "astyle" ];
          # cpp = [ "astyle" ];
          # css = [ "prettierd" "prettier" ];
          # cmake = [ "cmake_format" ];
          # go = [ "goimports" "gofumpt" "golines" ];
          html = [
            "prettierd"
            "prettier"
          ];
          # javascript = [ "prettierd" "prettier" ];
          # javascriptreact = [ "prettier" ];
          json = [ "prettier" ];
          lua = [ "stylua" ];
          markdown = [ "prettier" ];
          nix = [ "nixfmt" ];
          python = [
            "isort"
            "black"
          ];
          # rust = [ "rustfmt" ];
          sh = [ "shfmt" ];
          # typescript = [ "prettierd" "prettier" ];
          # typescriptreact = [ "prettier" ];
          yaml = [
            "prettierd"
            "prettier"
          ];
        };
        formatters = {
          asmfmt = {
            command = "asmfmt";
            stdin = true;
          };
        };
        format_on_save = {
          lsp_format = "fallback";
          timeou_ms = 500;
        };
      };
    };
  };
}
