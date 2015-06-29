#!/usr/bin/env bash
# gnu tools config

GNU_TOOLS="
gbase64
gbasename
gcat
gcksum
gcomm
gcsplit
gcut
gexpand
gexpr
gfactor
gfmt
gfold
ggroups
ghead
ginstall
gjoin
glink
gln
glogname
gmd5sum
gnl
gnproc
god
gpaste
gpathchk
gpr
greadlink
gruncon
gseq
gsha1sum
gsha224sum
gsha256sum
gsha384sum
gsha512sum
gshred
gshuf
gsleep
gsort
gsplit
gstat
gsum
gsync
gtac
gtail
gtee
gtest
gtimeout
gtr
gtruncate
gtsort
guname
gunexpand
guniq
gvdir
gwc"

for prog in ${GNU_TOOLS}; do
  # if there isn't a native version of the gnu tool
  # and there is a g-prefixed version of the tool,
  # alias the g-prefixed version to the bare name
  builtin hash ${prog#g} &>/dev/null || {
    builtin hash ${prog} &>/dev/null && alias ${prog#g}=${prog}
  }
done
unset GNU_TOOLS prog

# pretend we have gmake even if we don't
builtin hash gmake &>/dev/null || alias gmake='make'

# vim:set sw=2 ts=2 sts=2 et ft=sh:
