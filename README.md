# vimrc

## File Location

### vim

```
$HOME
  └─vim
     ├─setting
     │  ├─function
     │  └─plug
     └─vimwiki
```

### dll (for windows)
```
C:\Program Files\Vim\vim90
 ├─gvim.exe
 ├─gvimfullscreen_64.dll
 ├─vimtweak64.dll
 └─...
```

## vimrc

```vim
source ~/vim/setting/system.vim
source ~/vim/setting/user0.vim
source ~/vim/setting/map.vim
source ~/vim/setting/folding.vim

call plug#begin('~/.vim/plugged')
source ~/vim/vimwiki/vimwiki_setting.vim
source ~/vim/setting/plug/scheme.vim
source ~/vim/setting/plug/netrw.vim
source ~/vim/setting/plug/python.vim
"source ~/vim/setting/plug/repl.vim
"source ~/vim/setting/plug/vimtex.vim
"source ~/vim/setting/plug/ultisnip.vim
"source ~/vim/setting/plug/calendar.vim
call plug#end()

source ~/vim/setting/function/rename.vim
source ~/vim/setting/user1.vim
```
