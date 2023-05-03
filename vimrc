set nocompatible " be Improved, required
filetype off " required
" set runtime path to include Vundle 
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'itchyny/lightline.vim'
Plugin 'preservim/nerdtree'
Plugin 'tpope/vim-fugitive'
Plugin 'nvie/vim-flake8'
Plugin 'ambv/black'
Plugin 'neoclide/coc.nvim', {'branch': 'release'}
Plugin 'ryanoasis/vim-devicons'
Plugin 'sonph/onehalf', { 'rtp': 'vim' }
Plugin 'cespare/vim-toml'
Plugin 'rust-lang/rust.vim'
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
      \             [ 'gitbranch', 'filetype', 'filename', 'readonly', 'modified' ] ],
      \   'right': [ [ 'fileformat'], ['lineinfo', 'percent'] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead',
      \   'filetype': 'MyFileType',
      \   'fileformat': 'MyFileFormat',
      \ },
      \ }


function! MyFileType()
    return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol(): 'no ft'): ''
endfunction

function! MyFileFormat()
    return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

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
set encoding=utf-8
set nobackup
set nowritebackup

" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
