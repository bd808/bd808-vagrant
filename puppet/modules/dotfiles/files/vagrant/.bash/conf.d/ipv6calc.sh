#!/usr/bin/env bash
# ipv6calc config

builtin hash ipv6calc &>/dev/null && {
  alias ipv6info='ipv6calc -q --showinfo -i -m'
  alias ipv6macgen='ipv6calc --in prefix+mac --action prefixmac2ipv6 --out ipv6addr'
}


# vim: se sw=2 ts=2 sts=2 et ft=sh :
