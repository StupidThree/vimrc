autocmd BufNewFile *.wiki :call WikiTitle()
autocmd BufWrite,BufWritePre,FileWritePre *.wiki ks|call WikiSave()|'s
autocmd FileType vimwiki inoremap <F2> <esc>O<esc>:call append(line('.'),strftime('%Y-%m-%d %H:%M:%S'))<cr>jjA
autocmd FileType vimwiki nnoremap <LocalLeader>= :call WikiFormat()<cr>

func WikiTitle()
    let file_name=strpart(expand("%"),0,stridx(expand("%"),"."))
    let time_value=strftime("%Y-%m-%d %H:%M:%S")
    let date_value=strftime("%Y-%m-%d")
    call setline(1, "_create: ".time_value.'_')
    call append(line("."),"_save: ".time_value.'_') 
    call append(line(".")+1,"")
    call append(line(".")+2,"* [[wn.Vimwiki:index|Vimwiki]]")
    if match(file_name,'\d\{4,4}-\d\{2,2}-\d\{2,2}')==0
        call append(line(".")+3,"* [[wn.Diary:diary#".file_name."|Diary]]")
    else
        call append(line(".")+3,"* [[wn.Diary:diary|Diary]]")
    endif
    call append(line(".")+4,"* [[wn.Todo:index|Todo]]")
    call append(line(".")+5,"")
    call append(line(".")+6,"= ".file_name." =")
    autocmd BufNewFile * normal G
endfunc

func WikiSave()
    if line('$')<500
        call WikiFormat()
    endif
    let time_value=strftime("%Y-%m-%d %H:%M:%S")
    if getline(1)=~'_save:'
        call setline(1,"_save: ".time_value.'_')
    endif
    if getline(2)=~'_save:'
        call setline(2,"_save: ".time_value.'_')
    endif
endfunc

func WikiFormat()
    let num_lines=line('$')
    let lines=getline(1,num_lines)
    let add_lines=0
    for i in range(num_lines)
        if match(lines[i],'^=\+ .* =\+$')==0 && i>=1 && match(lines[i-1],'^\s*$')==-1
            call append(i+add_lines,"")
            let add_lines=add_lines+1
        endif
    endfor
endfunc

Plug 'vimwiki/vimwiki'
let g:vimwiki_menu=""
let g:vimwiki_folding="syntax"
let g:vimwiki_list = [
            \{
            \ 'path':'~/vim/vimwiki/',
            \ 'name':'Vimwiki',
            \ 'auto_diary_index':1,
            \},
            \{
            \ 'path':'~/vim/vimwiki/diary',
            \ 'name':'Diary',
            \ 'index':'../index',
            \ 'diary_rel_path':'',
            \},
            \{
            \ 'path':'~/vim/vimwiki/todo',
            \ 'name':'Todo',
            \ 'auto_diary_index':1,
            \},
            \{
            \ 'path':'~/vim/vimwiki/study/',
            \ 'name':'Study',
            \ 'nested_syntaxes': {'python':'python','c++':'cpp'}
            \},
            \{
            \ 'path':'~/vim/vimwiki/study/papernote',
            \ 'name':'PaperNote',
            \ 'nested_syntaxes': {'python':'python','c++':'cpp'}
            \},
            \{
            \ 'path':'~/vim/vimwiki/study/booknote',
            \ 'name':'BookNote',
            \ 'nested_syntaxes': {'python':'python','c++':'cpp'}
            \},
            \{
            \ 'path':'~/vim/vimwiki/study/coursenote',
            \ 'name':'CourseNote',
            \ 'nested_syntaxes': {'python':'python','c++':'cpp'}
            \},
            \{
            \ 'path':'~/vim/vimwiki/play/books',
            \ 'name':'Books',
            \},
            \{
            \ 'path':'~/vim/vimwiki/play/movies',
            \ 'name':'Movies',
            \},
            \{
            \ 'path':'~/vim/vimwiki/play/games',
            \ 'name':'Games',
            \}]
"let g:vimwiki_valid_html_tags = 'b,i,s,u,sub,sup,kbd,br,hr, pre, script'
let g:vimwiki_hl_cb_checked=1
"let g:vimwiki_folding='syntax'
let g:vimwiki_camel_case=0
