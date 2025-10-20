{ lib, opts, ... }:
{
  imports = lib.optional ((opts.proxy.method or "") != "") ./${opts.proxy.method};
}
