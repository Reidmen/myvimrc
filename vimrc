set nocompatible " be Improved, required
filetype off " required
" set runtime path to include Vundle 
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'preservim/nerdtree'
Plugin 'tpope/vim-fugitive'
Plugin 'nvie/vim-flake8'
Plugin 'ambv/black'
Plugin 'davidhalter/jedi-vim'
Plugin 'ryanoasis/vim-devicons'
Plugin 'sonph/onehalf', { 'rtp': 'vim' }
Plugin 'cespare/vim-toml'
" Plugin 'rust-lang/rust.vim'
" all plugins must be added before this line
call vundle#end() " required
filetype plugin indent on " required
" To ignore plugin indent changes, use
"filetype plugin on
"
" all other configuration from this line
syntax enable " enable highlight
colorscheme onehalfdark
let g:lightline = {
      \ 'colorscheme': 'onehalfdark',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_symbols.maxlinenr = '☰'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = '∄'
let g:airline_symbols.whitespace = 'Ξ'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.colnr = ' ℅'

let g:jedi#use_tabs_not_buffers = 1
let g:jedi#use_splits_not_buffers = "left"
let g:airline_theme='onehalfdark'
let g:airline#extensions#tabline#formatter = 'default'

set t_Co=256 " 256 colors
set number " set number
set laststatus=2 " works with set title
set title " set file title
set ts=4 " set tabs to 4 spaces
set autoindent " indent when moving into spaces
set expandtab " expand tabs into spaces
set shiftwidth=4 " when ussing >> or << ,shift lines by 4 spaces
set cursorline " show visual line under cursor
set showmatch " show matching pairs for [] {} ()
set ignorecase " search not case sensitive
set incsearch " incremental search
set hlsearch " highlighting search
set foldmethod=indent " syntax folding
set foldnestmax=10
set nowrap " do not wrap lines
set encoding=UTF-8
