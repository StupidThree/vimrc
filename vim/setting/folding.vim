autocmd FileType c,cpp set fdm=manual
"autocmd FileType vimwiki setlocal foldmethod=expr | setlocal foldenable | set foldexpr=VimwikiFoldLevelCustom(v:lnum) | set foldlevel=2
autocmd FileType python setlocal foldmethod=indent

function! VimwikiFoldLevelCustom(lnum)
    let x=getline(a:lnum)
    if x =~ '^\(=\+\) .* \1$'
        return '>'.strlen(matchstr(x,'^=\+'))
    endif
    if x =~? '\v^\s*$'
        if getline(a:lnum+1) =~ '^\(=\+\) .* \1$'
            return '-1'
        endif
    endif
    return '='
endfunction
