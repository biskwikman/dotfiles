set nocompatible
colorscheme darkblue
filetype on
filetype plugin on
filetype indent on
syntax on
set cursorline
set shiftwidth=4
set tabstop=4
set expandtab
set nobackup
set scrolloff=10
set nowrap
set incsearch
set ignorecase
set smartcase
set showcmd
set showmode
set showmatch
set hlsearch
set history=1000
set wildmenu
set wildmode=list:longest
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

" Status bar
let &t_SI = "\<esc>[5 q"
let &t_SR = "\<esc>[5 q"
let &t_EI = "\<esc>[2 q"


" LINTING ---------------------------------------------------------------- {{{

let g:ale_linters = {
\    'tex': ['chktex','cspell','lacheck','texlab'],
\} 

" }}}


" PLUGINS ---------------------------------------------------------------- {{{
call plug#begin('~/.vim/plugged')

    Plug 'dense-analysis/ale',
    Plug 'lervag/vimtex'

call plug#end()

let g:vimtex_view_method = 'zathura'

" }}}


" MAPPINGS --------------------------------------------------------------- {{{

" Mappings code goes here.

let mapleader = " "
map <leader>h :noh<CR>
map <leader>e :Lexplore<CR>
map gn :bnext<CR>
map gp :bprevious<CR>
map gc :bd<CR>
map <c-k> <c-w>k
map <c-j> <c-w>j
map <c-h> <c-w>h
map <c-l> <c-w>l
tnoremap jk <c-w>N

" Terminal
" map <leader>t :below term++rows=20<CR>
map <leader>t :call TermToggle()<CR>

function! TermToggle()
    if term_list() == []
        below term++rows=20
    else
        for termbuf in term_list()
            let termwinbuf = bufwinnr(termbuf)
            if termwinbuf == -1
                execute "below" "20split" | execute "buffer" termbuf
            else
                execute termwinbuf "wincmd" "w" | :hide 
            endif
        endfor
    endif
endfunction


" Map key chord `jk` to <Esc>.
let g:esc_j_lasttime = 0
let g:esc_k_lasttime = 0
function! JKescape(key)
	if a:key=='j' | let g:esc_j_lasttime = reltimefloat(reltime()) | endif
	if a:key=='k' | let g:esc_k_lasttime = reltimefloat(reltime()) | endif
	let l:timediff = abs(g:esc_j_lasttime - g:esc_k_lasttime)
	return (l:timediff <= 0.08) ? "\b\e" : a:key
endfunction
inoremap <expr> j JKescape('j')
inoremap <expr> k JKescape('k')

" }}}


" VIMSCRIPT -------------------------------------------------------------- {{{

" This will enable code folding.
" Use the marker method of folding.
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" More Vimscripts code goes here.

" }}}


" STATUS LINE ------------------------------------------------------------ {{{

" Status bar code goes here.

" }}}
