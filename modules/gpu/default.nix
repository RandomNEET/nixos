{ opts, lib, ... }:
{
  imports = lib.optional (opts.gpu != "") ./${opts.gpu};
}
