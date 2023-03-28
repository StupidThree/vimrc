Plug 'lervag/vimtex',{'for':'tex'}
let g:vimtex_latexmk_option='-pdf -pdflatex="xelatex -synctex=1 \%S \%O" -verbose -file-line-error -interaction=nonstopmode'
let g:tex_flavor='latex'
let g:vimtex_view_method='skim'
let g:vimtex_fold_enabled=1
let g:tex_fold_enabled=1
let g:vimtex_quickfix_mode=0
let g:vimtex_texcount_custom_arg=' -ch -total'
let g:vimtex_syntax_conceal_disable=1
au FileType tex map <buffer> <silent>  <leader>lw :VimtexCountWords!  <CR><CR>
