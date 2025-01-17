vim9script
set nocompatible
colorscheme darkblue
filetype on
filetype plugin on
filetype indent on
syntax on
set omnifunc=syntaxcomplete#Complete
set shiftwidth=4
set tabstop=8
set softtabstop=4
set noexpandtab
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
hi Terminal ctermbg=black
hi MatchParen cterm=none ctermfg=blue ctermbg=92

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
    Plug 'Apeiros-46B/uiua.vim',
    Plug 'tpope/vim-commentary',
    Plug 'mlochbaum/BQN', {'rtp': 'editors/vim'},
plug#end()

g:vimtex_view_method = 'zathura'

# }}}


# LSP ----------------------------------------------------------------- {{{
var lspOpts = {
    autoHighlight: v:true,
    autoHighlightDiags: v:true,
    autoComplete: v:false,
}
autocmd User LspSetup call LspOptionsSet(lspOpts)

var lspServers = [
    # Clang language server
    {
        name: 'clang',
		filetype: ['c', 'cpp'],
		path: '/usr/bin/clangd',
		args: ['--background-index'],
    },
    # Texlab language server
    {
        name: 'TexLab',
		filetype: ['tex', 'latex'],
		path: '/usr/bin/texlab',
    },
    # Julia language server
    {
        name: 'LanguageServer',
		filetype: ['jl'],
		path: '/home/dan/.juliaup/bin/julia',
        args: ['-e', 'using LanguageServer; server = LanguageServerInstance(stdin, stdout, "/home/dan/.julia/environments/v1.11"); server.runlinter = true; run(server);']
    },
    # Vimscript language server
    {
        name: 'vim-language-server',
		filetype: ['vim', 'vimrc'],
		path: 'vim-language-server',
        args: ['--stdio'],
        initializationOptions: {diagnostics: {enable: true}}
    },
    # Haskell language server
    {
        name: 'haskell-language-server',
		filetype: ['hs', 'haskell', 'lhaskell'],
		path: '/home/dan/.ghcup/bin/haskell-language-server-wrapper',
        args: ['--lsp'],
    },
    # Rust Analyzer
    {
        name: 'rustlang',
	filetype: ['rs', 'rust'],
	path: 'rust-analyzer',
        args: [],
	syncInit: v:true,
    },
    # uiua language server
    {
        name: 'uiua-language-server',
		filetype: ['ua', 'uiua'],
		path: '/home/dan/.cargo/bin/uiua',
        args: ['lsp'],
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
nnoremap <leader>d :LspDiag current<CR>

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
