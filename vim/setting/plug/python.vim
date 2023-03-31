Plug 'tell-k/vim-autopep8',{'for':'python'}
autocmd Filetype python nnoremap <leader>= :Autopep8<Cr>
let g:autopep8_disable_show_diff=1
"Plug 'tmhedberg/SimpylFold',{ 'for':'python'}
Plug 'Yggdroot/indentLine',{ 'for':['c','cpp','python']}
let g:indentLine_fileType=['c','cpp','python']
let g:indentLine_color_term=239
let g:indentLine_char_list=['|']
"autocmd VimEnter *.py Vexplore
