# interactive shell specific config

# configure fancy shell completion
[[ -f ${BASH_CONF}/bash_completion ]] && {
  # completion vars may be readonly, so check before spewing a bunch of errors
  $(readonly -p|grep BASH_COMPLETION >/dev/null 2>&1) || {
    export BASH_COMPLETION=${BASH_CONF}/bash_completion
    export BASH_COMPLETION_DIR=${BASH_CONF}/bash_completion.d
    . ${BASH_COMPLETION}
  }

  # more custom completions
  complete -C complete-ant-cmd ant
  complete -C complete-phing-cmd phing
}

# prompt tweaks
SHORT_HOST=${SHORT_HOST:-$(hostname -f|rev|cut -d. -f3-|rev)}
SHORT_HOST=${SHORT_HOST:-$(hostname -f)}
SHORT_HOST=${SHORT_HOST/.local/}
export SHORT_HOST

# git repo info (from git completion script)
GIT_PS1_SHOWDIRTYSTATE=yes
GIT_PS1_SHOWSTASHSTATE=yes
#GIT_PS1_SHOWUNTRACKEDFILES=yes
#GIT_PS1_SHOWUPSTREAM=auto
GIT_PS1_FORMAT=" (git %s)"
typeset -F | grep __gitdir &>/dev/null || function __gitdir { ''; }
typeset -F | grep __git_ps1 &>/dev/null || function __git_ps1 { ''; }

# svn checkout info
SVN_PS1_SHOWDIRTYSTATE=yes
SVN_PS1_SHOWUNTRACKEDFILES=yes
SVN_PS1_FORMAT=" (svn %s)"
__svn_ps1 () {
  local info=$(svn info 2>/dev/null) url branch status flags
  [[ -n $info ]] || return
  url=$(echo "$info"|sed -ne 's#^URL: ##p')
  if [[ $url =~ /trunk(/|$) ]]; then
    branch=trunk
  elif [[ $url =~ /branches/ ]]; then
    branch=${url##*branches/}
    branch=${branch%%/*}
  else
    branch=$(echo "$info"|sed -ne 's#^Repository Root: ##p')
    branch=${branch##*/}
  fi

  if [[ -n $SVN_PS1_SHOWDIRTYSTATE || -n $SVN_PS1_SHOWUNTRACKEDFILES ]]; then
    status=$(svn st 2>/dev/null)
    if [[ -n $SVN_PS1_SHOWDIRTYSTATE ]]; then
      echo "$status" | grep -E '^ ?(A|D|M|R)' &>/dev/null && flags="${flags}+"
      echo "$status" | grep -E '^ ?(C|!|~)' &>/dev/null && flags="${flags}!"
    fi
    if [[ $SVN_PS1_SHOWUNTRACKEDFILES ]]; then
      echo "$status" | grep -E '^\?' &>/dev/null && flags="${flags}%"
    fi
  fi
  printf "${1:- (%s)}" "$branch${flags:+ $flags}"
}

# mercurial checkout info
HG_PS1_SHOWDIRTYSTATE=yes
HG_PS1_SHOWUNTRACKEDFILES=yes
HG_PS1_FORMAT=" (hg %s)"
__hg_ps1 () {
  local branch=$(hg branch 2>/dev/null) status flags
  [[ -n $branch ]] || return

  if [[ -n $HG_PS1_SHOWDIRTYSTATE || -n $HG_PS1_SHOWUNTRACKEDFILES ]]; then
    status=$(hg status 2>/dev/null)
    if [[ -n $HG_PS1_SHOWDIRTYSTATE ]]; then
      echo "$status" | grep -E '^(M|A|R)' &>/dev/null && flags="${flags}+"
      echo "$status" | grep -E '^!' &>/dev/null && flags="${flags}!"
    fi
    if [[ $HG_PS1_SHOWUNTRACKEDFILES ]]; then
      echo "$status" | grep -E '^\?' &>/dev/null && flags="${flags}%"
    fi
  fi
  printf "${1:- (%s)}" "$branch${flags:+ $flags}"
}

# bazaar repo info
BZR_PS1_SHOWDIRTYSTATE=yes
BZR_PS1_SHOWUNTRACKEDFILES=yes
BZR_PS1_FORMAT=" (bzr %s)"
__bzr_ps1 () {
  local branch=$(bzr nick 2>/dev/null) status flags
  [[ -n $branch ]] || return

  if [[ -n $BZR_PS1_SHOWDIRTYSTATE || -n $BZR_PS1_SHOWUNTRACKEDFILES ]]; then
    status=$(bzr status -S 2>/dev/null)
    if [[ -n $BZR_PS1_SHOWDIRTYSTATE ]]; then
      echo "$status" | grep -E '^\s*(M|\+|R)' &>/dev/null && flags="${flags}+"
      echo "$status" | grep -E '^-' &>/dev/null && flags="${flags}!"
    fi
    if [[ $BZR_PS1_SHOWUNTRACKEDFILES ]]; then
      echo "$status" | grep -E '^\?' &>/dev/null && flags="${flags}%"
    fi
  fi
  printf "${1:- (%s)}" "$branch${flags:+ $flags}"
}

# bundle all of the vcs status checks into one convenient proc
__vcs_ps1 () {
  __gitdir &>/dev/null && __git_ps1 "${GIT_PS1_FORMAT}"
  #__hg_ps1 "${HG_PS1_FORMAT}"
  #__bzr_ps1 "${BZR_PS1_FORMAT}"
  #__svn_ps1 "${SVN_PS1_FORMAT}"
}

# primary prompt on two lines:
# truncated hostname:/current/path (vcs status)
# username$
export PS1="${SHORT_HOST}:\w \[\033[1;30m\]\$(__vcs_ps1)\[\033[0m\]\n\u\$ "
# continuation prompt as empty spaces for easy copy-n-paste
export PS2="    "
# set -x prefix shows source file and line number
export PS4='$0:$LINENO+ '

# term title
[[ -n "${DISPLAY}" || "${TERM}" != "${TERM/xterm/}" ]] && {
  # set xterm title on prompt display
  typeset -F | grep set_term_title &>/dev/null &&
  set_term_title

  # track the cwd in the term title
  #export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${SHORT_HOST}:${PWD/#$HOME/~}\007"'
}

# screen title
[[ $TERM =~ ^screen(-.*)?$ ]] && {
  # add a pretty screen buffer title
  $(typeset -F | grep set_screen_title >/dev/null 2>&1) && {
    set_screen_title "${USER}@${SHORT_HOST}"
  }
}

# turn off idle timeout if it's not readonly
$(readonly -p|grep TMOUT >/dev/null 2>&1) || export TMOUT=0

# vim:set sw=2 ts=2 et ft=sh:
