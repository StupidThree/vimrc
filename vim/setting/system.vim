if has('win32')
    " Vim with all enhancements
    source $VIMRUNTIME/vimrc_example.vim
    
    " Use the internal diff if available.
    " Otherwise use the special 'diffexpr' for Windows.
    if &diffopt !~# 'internal'
      set diffexpr=MyDiff()
    endif
    function MyDiff()
      let opt = '-a --binary '
      if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
      if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
      let arg1 = v:fname_in
      if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
      let arg1 = substitute(arg1, '!', '\!', 'g')
      let arg2 = v:fname_new
      if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
      let arg2 = substitute(arg2, '!', '\!', 'g')
      let arg3 = v:fname_out
      if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
      let arg3 = substitute(arg3, '!', '\!', 'g')
      if $VIMRUNTIME =~ ' '
        if &sh =~ '\<cmd'
          if empty(&shellxquote)
            let l:shxq_sav = ''
            set shellxquote&
          endif
          let cmd = '"' . $VIMRUNTIME . '\diff"'
        else
          let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
        endif
      else
        let cmd = $VIMRUNTIME . '\diff'
      endif
      let cmd = substitute(cmd, '!', '\!', 'g')
      silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
      if exists('l:shxq_sav')
        let &shellxquote=l:shxq_sav
      endif
    endfunction
elseif has('macunix')
    " An example for a vimrc file.
    "
    " Maintainer:	Bram Moolenaar <Bram@vim.org>
    " Last change:	2017 Sep 20
    "
    " To use it, copy it to
    "     for Unix and OS/2:  ~/.vimrc
    "	      for Amiga:  s:.vimrc
    "  for MS-DOS and Win32:  $VIM\_vimrc
    "	    for OpenVMS:  sys$login:.vimrc
    
    " When started as "evim", evim.vim will already have done these settings.
    if v:progname =~? "evim"
      finish
    endif
    
    " Get the defaults that most users want.
    source $VIMRUNTIME/defaults.vim
    
    if has("vms")
      set nobackup		" do not keep a backup file, use versions instead
    else
      set backup		" keep a backup file (restore to previous version)
      if has('persistent_undo')
        set undofile	" keep an undo file (undo changes after closing)
      endif
    endif
    
    if &t_Co > 2 || has("gui_running")
      " Switch on highlighting the last used search pattern.
      set hlsearch
    endif
    
    " Only do this part when compiled with support for autocommands.
    if has("autocmd")
    
      " Put these in an autocmd group, so that we can delete them easily.
      augroup vimrcEx
      au!
    
      " For all text files set 'textwidth' to 78 characters.
      autocmd FileType text setlocal textwidth=78
    
      augroup END
    
    else
    
      set autoindent		" always set autoindenting on
    
    endif " has("autocmd")
    
    " Add optional packages.
    "
    " The matchit plugin makes the % command work better, but it is not backwards
    " compatible.
    " The ! means the package won't be loaded right away but when plugins are
    " loaded during initialization.
    if has('syntax') && has('eval')
      packadd! matchit
    endif
endif
