{ ... }:
{
  programs.nixvim = {
    config.opts = {
      number = true;
      relativenumber = true;
      conceallevel = 1;
    };
  };
}
