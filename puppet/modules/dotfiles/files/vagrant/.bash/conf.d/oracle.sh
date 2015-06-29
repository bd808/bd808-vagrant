#!/usr/bin/env bash
# oracle config

# common locations for oracle client installs
# listed in order of preference
# TODO: make this more dynamic. I don't want to fix it for every fricking 
# point release.
ORACLE_ROOTS="
  /usr/lib/oracle/11.2/client
  /usr/lib/oracle/11.2/client64
  /usr/lib/oracle/11.1/client
  /usr/lib/oracle/11.1/client64
  /usr/lib/oracle/xe/app/oracle/product/10.2.0/client
  /opt/oracle/10.2/client
  /opt/oracle/product/11gR1/db_1
"

for r in ${ORACLE_ROOTS}; do
  debugLog checking ${r}
  [[ -d "${r}" ]] && {
    export ORACLE_HOME=${r}
    break
  }
done
unset ORACLE_ROOTS r

# load provided env script if available
source_file "${ORACLE_HOME}/bin/oracle_env.sh"

if [[ -f /etc/oracle/tnsnames.ora ]] ; then
  export TNS_ADMIN=/etc/oracle

else
  export TNS_ADMIN=${ORACLE_HOME}/network/admin
fi

export NLS_DATE_FORMAT='YYYY-MM-DD HH24:MI:SS'
export NLS_LANG=AMERICAN_AMERICA.UTF8

add_root_dir "${ORACLE_HOME}"
[[ -d "${ORACLE_HOME}/lib" ]] && add_library_path "${ORACLE_HOME}/lib"

# make sqlplus suck a little less
builtin hash rlwrap &>/dev/null && {
  alias sqlplus='rlwrap -b "" -f ${HOME}/.sqlplus/sql.dict -H ${HOME}/.sqlplus/history sqlplus'
}
export SQLPATH=${SQLPATH}${SQLPATH:+:}.:$HOME/.sqlplus

# vim: se sw=2 ts=2 sts=2 et ft=sh :
