# Make Control-v paste, if in X and if xclip available - Josh Triplett
# from http://www.debian-administration.org/articles/565
if [ -n "$DISPLAY" ] && [ -x /usr/bin/xclip ] ; then
    # Work around a bash bug: \C-@ does not work in a key binding
    bind '"\C-x\C-m": set-mark'
    # The '#' characters ensure that kill commands have text to work on; if
    # not, this binding would malfunction at the start or end of a line.
    bind 'Control-v: "#\C-b\C-k#\C-x\C-?\"$(xclip -o -selection c)\"\e\C-e\C-x\C-m\C-a\C-y\C-?\C-e\C-y\ey\C-x\C-x\C-d"'
fi
# vim: se sw=2 ts=2 tw=78 et ft=sh:
