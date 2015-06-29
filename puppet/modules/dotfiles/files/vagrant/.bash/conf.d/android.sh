#!/usr/bin/env bash

ANDROID_ROOTS="
${HOME}/projects/android-sdks
${HOME}/projects/android-sdk-osx
${HOME}/android-sdks
${HOME}/android-sdk-osx
"

for d in ${ANDROID_ROOTS}; do
  if [[ -d ${d} ]]; then
    export ANDROID_HOME=${d}
    list_add_dir PATH "${ANDROID_HOME}/tools"
    list_add_dir PATH "${ANDROID_HOME}/platform-tools"
    break
  fi
done
unset ANDROID_ROOTS d

# vim: se sw=2 ts=2 sts=2 et ft=sh :
