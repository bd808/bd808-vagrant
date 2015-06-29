# Darwin (OSX) specfic config

add_root_dir "/opt/local"
add_root_dir "/opt/gtk"

alias bzip='bzip2 -z'
alias bunzip='bzip2 -d'

hash seq &>/dev/null ||
alias seq='jot -'

# darwin's cal can't do the 3 month trick :(
unalias cal

# use 32 bit python on osx when possible (gtk hack)
export VERSIONER_PYTHON_PREFER_32_BIT=yes

# otool does what my brain expects ldd to do
alias ldd='otool -L'

# brew puts python scripts in a weird place
#[[ -d /usr/local/share/python && ! $PATH =~ /usr/local/share/python ]] &&
#  PATH="/usr/local/share/python:${PATH}"
[[ -d /usr/local/share/python ]] &&
  list_add_dir PATH /usr/local/share/python

# fix C-o in bash
# http://apple.stackexchange.com/questions/3253/ctrl-o-behavior-in-terminal-app
stty discard undef

# vim:set sw=2 ts=2 et ft=sh:
