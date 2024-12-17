vim9script
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

# Status bar
&t_SI = "\<esc>[5 q"
&t_SR = "\<esc>[5 q"
&t_EI = "\<esc>[2 q"


# LINTING ---------------------------------------------------------------- {{{


# }}}


# PLUGINS ---------------------------------------------------------------- {{{
plug#begin('~/.vim/plugged')

    Plug 'yegappan/lsp',
    Plug 'lervag/vimtex',
    Plug 'JuliaEditorSupport/julia-vim',

plug#end()

g:vimtex_view_method = 'zathura'

# }}}


# LSP ----------------------------------------------------------------- {{{
var lspOpts = {autoHighlightDiags: v:true}
autocmd User LspSetup call LspOptionsSet(lspOpts)

var lspServers = [
    # Clang language server
    {
        name: 'clang',
		filetype: ['c', 'cpp'],
		path: '/usr/bin/clangd',
		args: ['--background-index'],
    },
    # Julia language server
	{
        name: 'LanuageServer',
		filetype: ['jl', 'julia'],
        path: '/home/dan/.juliaup/bin/julia',
		args: ['--project=/home/dan/.julia/environments/v1.11 -e "using LanguageServer; runserver()"'],
    },
    # Vim langauge server
	{
        name: 'LanuageServer',
		filetype: ['jl', 'julia'],
        path: '/home/dan/.juliaup/bin/julia',
		args: ['--project=/home/dan/.julia/environments/v1.11 -e "using LanguageServer; runserver()"'],
    },
]
    
autocmd User LspSetup call LspAddServer(lspServers)

# }}}


# MAPPINGS --------------------------------------------------------------- {{{

# Mappings code goes here.

g:mapleader = " "
map <leader>h :noh<CR>
map <leader>e :Lexplore<CR>
map gn :bnext<CR>
map gp :bprevious<CR>
map gc :bd<CR>
map <c-k> <c-w>k
map <c-j> <c-w>j
map <c-h> <c-w>h
map <c-l> <c-w>l
inoremap jk <ESC>
tnoremap jk <c-w>N

# }}}


# VIMSCRIPT -------------------------------------------------------------- {{{

# This will enable code folding.
# Use the marker method of folding.
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

# Terminal
def g:TermToggle()
    if term_list() == []
        below term ++rows=20
    else
        for termbuf in term_list()
            var termwinbuf = bufwinnr(termbuf)
            if termwinbuf == -1
                execute "below" ":20split" | execute "buffer" termbuf
            else
                execute ":"termwinbuf "wincmd" "w"
                hide
            endif
        endfor
    endif
enddef
map <leader>t :call TermToggle()<CR>


# }}}


# STATUS LINE ------------------------------------------------------------ {{{

# Status bar code goes here.

# }}}
