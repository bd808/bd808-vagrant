#!/usr/bin/env bash
# java config

builtin hash java &>/dev/null && {
  [[ -z "${JAVA_HOME}" ]] && {
    # find out what java runtime thinks java.home is
    JAVA_RUNTIME=$(java -cp ${BASH_CONF}/lib/javahome.jar com.bd808.homedir.JavaHome)
    # JAVA_HOME should be one directory higher (most of the time)
    JAVA_HOME=$(canonicalize "${JAVA_RUNTIME}/..")
    export JAVA_HOME
  }

  [[ ( "Darwin" = $(uname -s) ) && ( -d "${JAVA_HOME}/Home" ) ]] && {
    # apple does a weird thing with their java_home location
    JAVA_HOME="${JAVA_HOME}/Home"
  }
}


# vim: se sw=2 ts=2 sts=2 et ft=sh :
