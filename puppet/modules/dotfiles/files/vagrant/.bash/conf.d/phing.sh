#!/usr/bin/env bash
# phing config

# check for custom phing
[[ -d ${HOME}/projects/phing ]] && {
  list_add_dir PATH "${HOME}/projects/phing/bin"
  export PHPRC=${HOME}/projects/phing
}

alias phing="phing -find build.xml"
#alias fresh='svn up && phing clean configure && ka'

# vim:set sw=2 ts=2 sts=2 et ft=sh:
