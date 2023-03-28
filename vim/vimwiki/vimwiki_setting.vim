autocmd BufNewFile *.wiki :call WikiTitle()
autocmd BufWrite,BufWritePre,FileWritePre *.wiki ks|call WikiSave()|'s
autocmd FileType vimwiki nnoremap <LocalLeader>= :call WikiFormat()<cr>
"autocmd FileType vimwiki :call WikiOpen()
autocmd FileType vimwiki nnoremap <F2> :call append(line('$'),'== '.strftime('%Y-%m-%d %H:%M:%S').' ==')<cr>Go
autocmd FileType vimwiki set foldlevel=1

func WikiOpen()
    let file_name=strpart(expand("%"),0,stridx(expand("%"),"."))
    let file_path=strpart(expand("%:p"),0,stridx(expand("%:p"),expand("%")))
    if file_name=='index'
        set foldlevel=100
    endif
    if file_name=~'\d\{4,4}-\d\{2,2}-\d\{2,2}' && file_path =~ 'diary'
        set foldlevel=100
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
    if file_name=~'\d\{4,4}-\d\{2,2}-\d\{2,2}' && file_path =~ 'diary'
        call append(line("$"),"* [[wn.Diary:index#".file_name."|Diary]]")
    else
        call append(line("$"),"* [[wn.Diary:index|Diary]]")
    endif
    call append(line("$"),"* [[wn.Todo:index|Todo]]")
    call append(line("$"),"* [[wn.Study:index|Study]]")
    call append(line("$"),"* [[wn.Life:index|Life]]")
    call append(line("$"),"")
    call append(line("$"),"= ".file_name." =")
    if  file_path =~ "books"
        call append(line("$"),'author: ')
        call append(line("$"),'')
        call append(line("$"),'== Excerpts ==')
        call append(line("$"),'')
        call append(line("$"),'== Feelings ==')
    endif
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

func WikiLineState(line)
    if a:line=~'^\s*$'
        return 0
    endif
    if a:line=~'^\(=\+\) .* \1$'
        return 1
    endif
    return 2
endfunc

func WikiFormat()
    let i=2
    while i<=line('$')
        if WikiLineState(getline(i))==1
            if WikiLineState(getline(i-1))==2
                call append(i-1,"")
            elseif WikiLineState(getline(i-1))==0 && i>=2 && WikiLineState(getline(i-2))!=2
                call deletebufline(bufname(),i-1,i-1)
                let i=i-2
            endif
        endif
        let i=i+1
    endwhile
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
let wiki_life= { 
            \ 'name':'Life',
            \ 'path':'~/vim/vimwiki/life',
            \ 'diary_rel_path':'log',
            \ 'diary_index':'index',
            \ 'diary_frequency':'monthly',
            \} " Life -> Life-Log
let wiki_life_log= { 
            \ 'name':'--Life Log',
            \ 'path':'~/vim/vimwiki/life/log',
            \ 'index':'index',
            \ 'diary_header':'Life Log',
            \ 'diary_rel_path':'',
            \ 'diary_index':'index',
            \ 'diary_frequency':'monthly',
            \ 'auto_diary_index':1,
            \} " Life-Log -> Life-Log
let wiki_life_books= { 
            \ 'name':'--Books',
            \ 'path':'~/vim/vimwiki/life/books',
            \ 'diary_rel_path':'../log',
            \ 'diary_index':'index',
            \ 'diary_frequency':'monthly',
            \} " Life-Books -> Life-Log
let wiki_life_movies= { 
            \ 'path':'~/vim/vimwiki/life/movies',
            \ 'name':'--Movies',
            \ 'diary_rel_path':'../log',
            \ 'diary_index':'index',
            \ 'diary_frequency':'monthly',
            \} " Life-Movies -> Life-Log
let wiki_life_games= { 
            \ 'path':'~/vim/vimwiki/life/games',
            \ 'name':'--Games',
            \ 'diary_rel_path':'../log',
            \ 'diary_index':'index',
            \ 'diary_frequency':'monthly',
            \} " Life-Games -> Life-Log
let wiki_life_showbiz= { 
            \ 'path':'~/vim/vimwiki/life/showbiz',
            \ 'name':'--Showbiz',
            \ 'diary_rel_path':'../log',
            \ 'diary_index':'index',
            \ 'diary_frequency':'monthly',
            \} " Life-Showbiz -> Life-Log
let wiki_life_podcasts= { 
            \ 'path':'~/vim/vimwiki/life/podcasts',
            \ 'name':'--Podcasts',
            \ 'diary_rel_path':'../log',
            \ 'diary_index':'index',
            \ 'diary_frequency':'monthly',
            \} " Life-Podcasts -> Life-Log
let wiki_life_forum= { 
            \ 'path':'~/vim/vimwiki/life/forum',
            \ 'name':'--Forum',
            \ 'diary_rel_path':'../log',
            \ 'diary_index':'index',
            \ 'diary_frequency':'monthly',
            \} " Life-Forum -> Life-Log
let wiki_life_videos= { 
            \ 'path':'~/vim/vimwiki/life/videos',
            \ 'name':'--Videos',
            \ 'diary_rel_path':'../log',
            \ 'diary_index':'index',
            \ 'diary_frequency':'monthly',
            \} " Life-Videos -> Life-Log
let g:vimwiki_list = [wiki_vimwiki,wiki_diary,wiki_todo,
            \ wiki_study,wiki_study_papernote,wiki_study_booknote,wiki_study_coursenote,wiki_study_log,
            \ wiki_life,wiki_life_books,wiki_life_movies,wiki_life_games,wiki_life_videos,wiki_life_podcasts,wiki_life_forum,wiki_life_showbiz,wiki_life_log]
"let g:vimwiki_valid_html_tags = 'b,i,s,u,sub,sup,kbd,br,hr, pre, script'
let g:vimwiki_hl_cb_checked=1
let g:vimwiki_folding='syntax'
let g:vimwiki_camel_case=0
