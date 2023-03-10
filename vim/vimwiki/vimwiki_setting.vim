autocmd BufNewFile *.wiki :call WikiTitle()
autocmd BufWrite,BufWritePre,FileWritePre *.wiki ks|call WikiSave()|'s
autocmd FileType vimwiki nnoremap <LocalLeader>= :call WikiFormat()<cr>
autocmd FileType vimwiki :call WikiOpen()

func WikiOpen()
    let file_name=strpart(expand("%"),0,stridx(expand("%"),"."))
    let file_path=strpart(expand("%:p"),0,stridx(expand("%:p"),expand("%")))
    if file_name=='index'
        set foldlevel=100
    endif
    if match(file_name,'\d\{4,4}-\d\{2,2}-\d\{2,2}')==0 && file_path =~ 'diary'
        set foldlevel=100
        nnoremap <F2> :call append(line('$'),'== '.strftime('%Y-%m-%d %H:%M:%S').' ==')<cr>Go
    endif
endfunc

func WikiTitle()
    let file_name=strpart(expand("%"),0,stridx(expand("%"),"."))
    let file_path=strpart(expand("%:p"),0,stridx(expand("%:p"),expand("%")))
    let time_value=strftime("%Y-%m-%d %H:%M:%S")
    let date_value=strftime("%Y-%m-%d")
    call setline(1, "_create: ".time_value.'_')
    call append(line("$"),"_save: ".time_value.'_') 
    call append(line("$"),"")
    call append(line("$"),"* [[wn.Vimwiki:index|Vimwiki]]")
    if match(file_name,'\d\{4,4}-\d\{2,2}-\d\{2,2}')==0 && file_path =~ 'diary'
        call append(line("$"),"* [[wn.Diary:index#".file_name."|Diary]]")
    else
        call append(line("$"),"* [[wn.Diary:index|Diary]]")
    endif
    call append(line("$"),"* [[wn.Todo:index|Todo]]")
    call append(line("$"),"* [[wn.Study:index|Study]]")
    call append(line("$"),"* [[wn.Play:index|Play]]")
    call append(line("$"),"")
    call append(line("$"),"= ".file_name." =")
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
        if match(lines[i],'^\(=\+\) .* \1$')==0 && i>=1 && match(lines[i-1],'^\s*$')==-1
            call append(i+add_lines,"")
            let add_lines=add_lines+1
        endif
    endfor
endfunc

Plug 'vimwiki/vimwiki'
let g:vimwiki_menu=""
let g:vimwiki_folding="expr"
let wiki_vimwiki= { 
            \ 'name':'Vimwiki',
            \ 'path':'~/vim/vimwiki/',
            \ 'index':'index',
            \ 'diary_rel_path':'diary',
            \ 'diary_index':'index',
            \ 'diary_frequency':'daily',
            \} " Vimwiki -> Diary
let wiki_diary= { 
            \ 'name':'Diary',
            \ 'path':'~/vim/vimwiki/diary',
            \ 'index':'index',
            \ 'diary_header':'Diary',
            \ 'diary_rel_path':'',
            \ 'diary_index':'index',
            \ 'diary_frequency':'daily',
            \ 'auto_diary_index':1,
            \} " Diary -> Diary
let wiki_todo= { 
            \ 'name':'Todo',
            \ 'path':'~/vim/vimwiki/todo',
            \ 'diary_header':'Todo Log',
            \ 'diary_rel_path':'Log',
            \ 'diary_index':'index',
            \ 'auto_diary_index':1,
            \} " Todo -> Todo-Log
let wiki_study= { 
            \ 'name':'Study',
            \ 'path':'~/vim/vimwiki/study/',
            \ 'index':'index',
            \ 'nested_syntaxes': {'python':'python','c++':'cpp','shell':'sh'},
            \ 'diary_rel_path':'log',
            \ 'diary_index':'index',
            \ 'diary_frequency':'weekly',
            \} " Study -> Study-Log
let wiki_study_log= { 
            \ 'name':'--Study Log',
            \ 'path':'~/vim/vimwiki/study/log',
            \ 'index':'index',
            \ 'nested_syntaxes': {'python':'python','c++':'cpp','shell':'sh'},
            \ 'diary_header':'Study Log',
            \ 'diary_rel_path':'',
            \ 'diary_index':'index',
            \ 'diary_frequency':'weekly',
            \ 'auto_diary_index':1,
            \} " Study-Log -> Study-Log
let wiki_study_papernote= { 
            \ 'name':'--PaperNote',
            \ 'path':'~/vim/vimwiki/study/papernote',
            \ 'nested_syntaxes': {'python':'python','c++':'cpp','shell':'sh'},
            \ 'diary_rel_path':'../log',
            \ 'diary_index':'index',
            \ 'diary_frequency':'weekly',
            \} " Study-PaperNote -> Study-Log
let wiki_study_booknote= { 
            \ 'name':'--BookNote',
            \ 'path':'~/vim/vimwiki/study/booknote',
            \ 'nested_syntaxes': {'python':'python','c++':'cpp','shell':'sh'},
            \ 'diary_rel_path':'../log',
            \ 'diary_index':'index',
            \ 'diary_frequency':'weekly',
            \} " Study-BookNote -> Study-Log
let wiki_study_coursenote= { 
            \ 'name':'--CourseNote',
            \ 'path':'~/vim/vimwiki/study/coursenote',
            \ 'nested_syntaxes': {'python':'python','c++':'cpp','shell':'sh'},
            \ 'diary_rel_path':'../log',
            \ 'diary_index':'index',
            \ 'diary_frequency':'weekly',
            \} " Study-CoureseNote -> Study-Log
let wiki_play= { 
            \ 'name':'Play',
            \ 'path':'~/vim/vimwiki/play',
            \ 'diary_rel_path':'log',
            \ 'diary_index':'index',
            \ 'diary_frequency':'monthly',
            \} " Play -> Play-Log
let wiki_play_log= { 
            \ 'name':'--Play Log',
            \ 'path':'~/vim/vimwiki/play/log',
            \ 'index':'index',
            \ 'diary_header':'Play Log',
            \ 'diary_rel_path':'',
            \ 'diary_index':'index',
            \ 'diary_frequency':'monthly',
            \ 'auto_diary_index':1,
            \} " Play-Log -> Play-Log
let wiki_play_books= { 
            \ 'name':'--Books',
            \ 'path':'~/vim/vimwiki/play/books',
            \ 'diary_rel_path':'../log',
            \ 'diary_index':'index',
            \ 'diary_frequency':'monthly',
            \} " Play-Books -> Play-Log
let wiki_play_movies= { 
            \ 'path':'~/vim/vimwiki/play/movies',
            \ 'name':'--Movies',
            \ 'diary_rel_path':'../log',
            \ 'diary_index':'index',
            \ 'diary_frequency':'monthly',
            \} " Play-Movies -> Play-Log
let wiki_play_games= { 
            \ 'path':'~/vim/vimwiki/play/games',
            \ 'name':'--Games',
            \ 'diary_rel_path':'../log',
            \ 'diary_index':'index',
            \ 'diary_frequency':'monthly',
            \} " Play-Games -> Play-Log
let g:vimwiki_list = [wiki_vimwiki,wiki_diary,wiki_todo,
            \ wiki_study,wiki_study_log,wiki_study_papernote,wiki_study_booknote,wiki_study_coursenote,
            \ wiki_play,wiki_play_log,wiki_play_books,wiki_play_movies,wiki_play_games]
"let g:vimwiki_valid_html_tags = 'b,i,s,u,sub,sup,kbd,br,hr, pre, script'
let g:vimwiki_hl_cb_checked=1
let g:vimwiki_folding='custom'
let g:vimwiki_camel_case=0
