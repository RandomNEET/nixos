{ lib, opts, ... }:
{
  imports = lib.optional (opts.proxy.method != "") ./${opts.proxy.method};
}
