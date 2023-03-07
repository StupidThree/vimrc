Plug 'sirver/ultisnips'
"let g:UltiSnipsSnippetDirectories = [$HOME.'/.vim/UltiSnips']
"let g:UltiSnipsSnippetDirectories = ['~/.vim/Ultisnips']
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
   " augroup VimTeX
   "  autocmd!
   "  autocmd BufReadPre /path/to/project/*.tex
   "        \ let b:vimtex_main = '/path/to/project/main.tex'
   "augroup END
let g:UltiSnipsEditSplit="vertical"
set conceallevel=1
let g:tex_conceal='abdmg'
