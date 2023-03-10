tmap <esc> <C-\><C-N>
tmap <ScrollWheelUp> <esc><C-Y>
tmap <ScrollWheelDown> <esc><C-E>
autocmd FileType c,cpp inoremap <F12> <esc>o{<cr>}<esc>O
"autocmd VimEnter *.py Vexplore
nnoremap <LocalLeader>t :term ++rows=15<cr>ssh lab<cr>conda activate pytorch39<cr>
nnoremap <LocalLeader>r :REPLToggle<esc>

if has('macunix')
    nmap <Leader>wn <Plug>VimwikiDiaryNextDay
    nmap <Leader>wp <Plug>VimwikiDiaryPrevDay
endif
