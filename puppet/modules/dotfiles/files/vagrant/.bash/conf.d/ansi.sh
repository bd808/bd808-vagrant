#!/usr/bin/env bash

ANSI_FORE_BLACK=30
ANSI_FORE_RED=31
ANSI_FORE_GREEN=32
ANSI_FORE_YELLOW=33
ANSI_FORE_BLUE=34
ANSI_FORE_MAGENTA=35
ANSI_FORE_CYAN=36
ANSI_FORE_WHITE=37
ANSI_FORE_RESET=39

ANSI_BACK_BLACK=40
ANSI_BACK_RED=41
ANSI_BACK_GREEN=42
ANSI_BACK_YELLOW=43
ANSI_BACK_BLUE=44
ANSI_BACK_MAGENTA=45
ANSI_BACK_CYAN=46
ANSI_BACK_WHITE=47
ANSI_BACK_RESET=49

ANSI_STYLE_BRIGHT=1
ANSI_STYLE_DIM=2
ANSI_STYLE_UNDERLINE=4
ANSI_STYLE_BLINK=5
ANSI_STYLE_INVERSE=7
ANSI_STYLE_NORMAL=22
ANSI_STYLE_NOBLINK=25
ANSI_RESET_ALL=0

ansi () {
  local _ifs=${IFS}
  IFS=";"
  printf "\033[%sm" "${@}"
  IFS=${_ifs}
}

ansi_reset () {
  ansi ${ANSI_RESET_ALL}
}

ansi_rainbow () {
  local i=0 src=$* c
  while [[ $i -lt ${#src} ]]; do
    c=$(($ANSI_FORE_RED+($i%7)))
    printf "%s" $(ansi $c)
    #[[ $c == $ANSI_FORE_BLUE ]] && printf "%s" $(ansi $ANSI_BACK_CYAN)
    #[[ $((i%14)) -gt 6 ]] && printf "%s" $(ansi $ANSI_STYLE_INVERSE)
    [[ $((i%28)) -gt 14 ]] && printf "%s" $(ansi $ANSI_STYLE_BRIGHT)
    [[ $((i%35)) -gt 28 ]] && printf "%s" $(ansi $ANSI_STYLE_DIM)
    printf "%s%s" "${src:$i:1}" $(ansi_reset)
    i=$((i+1))
  done
  echo
}

ascii_unicorn () {
cat <<"EOD"
\.
 \\      .
  \\ _,.+;)_
  .\\;~%:88%%.
 (( a   `)9,8;%.
 /`   _) ' `9%%%?
(' .-' j    '8%%'
 `"+   |    .88%)+._____..,,_   ,+%$%.
       :.   d%9`             `-%*'"'~%$.
    ___(   (%C                 `.   68%%9
  ."        \7                  ;  C8%%)`
  : ."-.__,'.____________..,`   L.  \86' ,
  : L    : :            `  .'\.   '.  %$9%)
  ;  -.  : |             \  \  "-._ `. `~"
   `. !  : |              )  >     ". ?
     `'  : |            .' .'       : |
         ; !          .' .'         : |
        ,' ;         ' .'           ; (
       .  (         j  (            `  \
       """'          ""'             `""
EOD
}

# example:
# echo $(ansi $ANSI_FORE_BLUE $ANSI_BACK_YELLOW $ANSI_STYLE_BRIGHT \
#     $ANSI_STYLE_UNDERLINE $ANSI_STYLE_BLINK) hello \
#     $(ansi $ANSI_STYLE_INVERSE) world $(ansi reset)
