#!/usr/bin/env bash
# subversion config

alias snv='svn'
alias svnst="svn st|egrep '^[^PX]'"

svndiff () {
  svn diff "${@}" | vim -XR -c "set ft=diff" -
}

# vim:set sw=2 ts=2 sts=2 et ft=sh:
