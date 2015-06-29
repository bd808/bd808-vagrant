" dpaste.vim: Vim plugin for pasting to dpaste.de
" Maintainer:   Bryan Davis <bd808@bd808.com>
" Version:      0.0.1
"
" Usage:
"   :Dpaste     create a paste from the current buffer or selection.

function! s:DpasteInit()
python << EOF

import vim
import urllib2, urllib

def new_paste(**paste_data):
    """
    The function that does all the magic work
    """

    url = "https://dpaste.de/api/"
    data = urllib.urlencode(paste_data)

    try:
        req = urllib2.Request(url)
        fd = urllib2.urlopen(req, data)
    except urllib2.URLError:
        return False

    return fd.read()[1:-1]

def make_utf8(code):
    enc = vim.eval('&fenc') or vim.eval('&enc')
    return code.decode(enc, 'ignore').encode('utf-8')

EOF
endfunction


function! s:Dpasteit(line1,line2,count,...)
call s:DpasteInit()
python << endpython

# new paste
if vim.eval('a:0') != '1':
    rng_start = int(vim.eval('a:line1')) - 1
    rng_end = int(vim.eval('a:line2'))

    if int( vim.eval('a:count') ):
        code = "\n".join(vim.current.buffer[rng_start:rng_end])
    else:
        code = "\n".join(vim.current.buffer)

    code = make_utf8(code)
    paste_data = dict(content=code)
    paste_url = new_paste(**paste_data)

    if paste_url:
        print "Pasted content to %s" % (paste_url)

        vim.command('setlocal nomodified')
        vim.command('let b:dpaste_url="%s"' % paste_url)
    else:
        print "Could not connect."
endpython
endfunction

command! -range=0 -nargs=* Dpaste :call s:Dpasteit(<line1>,<line2>,<count>,<f-args>)




