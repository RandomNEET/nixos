{ ... }: {
  programs.nixvim = {
    config.opts = {
      number = true;
      relativenumber = true;
    };
  };
}
