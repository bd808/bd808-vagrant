# bash startup config
#
# Bryan Davis <bd808@bd808.com>

# make sure HOME is set and non-null
: ${HOME=~}

# bash config dir. Defaults to ~/.bash but you can override if sourcing
# eg: BASH_CONF=~bd808/.bash source ~bd808/.bashrc
: ${BASH_CONF=${HOME}/.bash}

# what flavor of boxen are we?
: ${UNAME=$(uname -s)}
# strip OS type and version under Cygwin (e.g. CYGWIN_NT-5.1 => CYGWIN)
UNAME=${UNAME/CYGWIN_*/CYGWIN}

# who am i
: ${USER=$(id -un)}

# default umask rw-r--r--
umask 0022

# turn on core dumps
ulimit -c unlimited

# append to history instead of replacing
shopt -s histappend >/dev/null 2>&1
# line oriented history
shopt -s lithist >/dev/null 2>&1
# allow correction of invalid commands
shopt -s histreedit >/dev/null 2>&1
# fancy globs
shopt -s extglob >/dev/null 2>&1
# I can't spell or type
shopt -s cdspell >/dev/null 2>&1
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize >/dev/null 2>&1
# don't tab complete on an empty line
shopt -s no_empty_cmd_completion >/dev/null 2>&1

# de-dup history; start cmd with a space to hide it
export HISTCONTROL=ignoredups:ignorespace
# ignore: repeats, dir lists, job control, quitters
export HISTIGNORE="&:l[sl]:[bf]g:exit"
# don't tab complete output files and other junk
export FIGNORE='*.o:*.pyc:*.class:.swp:.swa'

# find out right away when background jobs end
set -o notify

# who has a local mail spool these days?
unset MAILCHECK

# set a sane locale if not done yet
: ${LANG:="en_US.UTF-8"}
: ${LANGUAGE:="en"}
: ${LC_CTYPE:="en_US.UTF-8"}
: ${LC_ALL:="en_US.UTF-8"}
export LANG LANGUAGE LC_CTYPE LC_ALL

# vim! if we can, vi if we can't
EDITOR=vi
hash vim &>/dev/null && EDITOR=vim
VISUAL=${EDITOR}
export EDITOR VISUAL

export SHELL=$(which bash)

# translate funky terminals into something more normal
tput -T $TERM colors 2>&1 >/dev/null ||
  export TERM=xterm
#[[ "xterm-256color" = "$TERM" ]] && export TERM=xterm

# load functions
[[ -d ${BASH_CONF}/functions.d ]] &&
for script in ${BASH_CONF}/functions.d/*.sh ; do
  source "${script}"
done
unset script

: ${MANPATH=$(manpath 2>/dev/null)}

# add common directories with bin,man,info,lib parts
add_root_dir "${HOME}"
add_root_dir "${HOME}/.local"
add_root_dir "${HOME}/opt"
add_root_dir "${HOME}/sw"

# load additional configs
[[ -d ${BASH_CONF}/conf.d ]] &&
for script in ${BASH_CONF}/conf.d/*.sh ; do
  source_file "${script}"
done
unset script

# load network specfic config
DOMAIN=$(hostname -f | cut -d. -f2-)
source_file "${BASH_CONF}/networks.d/${DOMAIN}.sh"

# load os specific config
source_file "${BASH_CONF}/os.d/${UNAME}.sh"

# load host specific config
source_file "${BASH_CONF}/hosts.d/$(hostname -f).sh"

# load local config
source_file "${HOME}/.bashrc.local"

# load interactive shell config if appropriate
[[ "$-" == *i* ]] && source_file ${BASH_CONF}/interactive.sh

# vim:sw=2 ts=2 sts=2 et ft=sh:
