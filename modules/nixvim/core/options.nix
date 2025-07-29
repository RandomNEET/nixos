{ ... }:
{
  programs.nixvim = {
    config.opts = {
      number = true;
      relativenumber = true;
      splitright = true;
      splitbelow = true;
    };
  };
}
