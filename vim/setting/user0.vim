if has('win32')
    set pythonthreedll=C:\\Users\\chenthree\\anaconda3\\python39.dll
    set pythonthreehome=C:\\Users\\chenthree\\anaconda3
    
    language messages zh_CN.utf-8
    language en_US
    
    set guioptions-=T
    set guioptions-=r
    set guioptions-=L
    set guioptions-=m
    
    let &t_ti.="\e[1 q"
    let &t_SI.="\e[5 q"
    "let &t_SR.="\e[4 q"
    let &t_EI.="\e[1 q"
    let &t_te.="\e[0 q"

    if has("gui_running")
        "autocmd VimEnter * call Fullscreen()
        autocmd VimEnter * exec libcallnr("vimtweak64.dll", "SetAlpha", 220)
    endif
    function Fullscreen()
        silent exec libcallnr("gvimfullscreen_64.dll", "ToggleFullScreen", 0)
        "silent exec libcallnr("vimtweak64.dll", "EnableTopMost", 1)
    endfunction
    function DisFullscreen()
        silent exec libcallnr("gvimfullscreen_64.dll", "ToggleFullScreen", 0)
        "silent exec libcallnr("vimtweak64.dll", "EnableTopMost", 0)
    endfunction
    map <F11> <Esc>:call Fullscreen()<CR>
    map <F10> <Esc>:call DisFullscreen()<CR>
    function! s:rename_file(new_file_path)
        execute 'saveas ' . a:new_file_path
        call delete(expand('#:p'))
        bd #
    endfunction
endif

filetype on
set nocompatible
filetype plugin on

set nobackup			" 禁止生成临时文件
set noswapfile			" 不需要备份
set autoread			" 自动检测外部更改

syntax on				" 语法高亮
set number				" 显示行号
"set relativenumber		" 显示相对行号
set guifont=Consolas	" 字体
set nowrap				" 关闭自动换行

set encoding=utf-8		" 编码
set ambiwidth=double	" 中文标点

set smartindent			" 智能缩进
set tabstop=4			" tab为4字符
set shiftwidth=4		" 自动缩进为4字符
set softtabstop=-1		" softtabstop值与shiftwidth一致
set expandtab			" space代替tab

set splitright			" 水平分割时，新窗口出现在右侧
set splitbelow			" 垂直分割时，新窗口出现在下册
set autochdir

set background=dark
