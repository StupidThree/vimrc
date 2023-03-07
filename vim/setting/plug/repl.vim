Plug 'sillybun/vim-repl',{'for':'python'}
let g:repl_python_pre_launch_command='ssh lab && conda activate pytorch39'
let g:repl_program={'python':'ipython'}
let g:sendtorepl_invoke_key="<leader>e"
let g:repl_position = 3
nnoremap <LocalLeader>r :REPLToggle<esc>
