" java files

if !exists('g:java_source_prefixes')
  let g:java_source_prefixes = [
      \ '/src/java/', '/src/main/java/', '/src/main/', '/src/', '/lib/',
      \ '/src/test/java/', '/src/test/', '/tests'
      \ ]
endif

function! s:stripPrefix(path)
  let l:path = a:path
  for l:prefix in g:java_source_prefixes
    let l:cut = stridx(l:path, l:prefix)
    if l:cut != -1
      let l:path = strpart(l:path, l:cut + strlen(l:prefix))
      break
    endif
  endfor
  return l:path
endfunction "s:stripPrefix

function! s:trPath(path, char)
  return join(split(s:stripPrefix(a:path), '/'), a:char)
endfunction

function! TSkeleton_PACKAGE()
  return s:trPath(expand('%:p:h'), '.')
endfunction "TSkeleton_PACKAGE
