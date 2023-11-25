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
Plugin 'bfrg/vim-cpp-modern'
Plugin 'vim-python/python-syntax'
Plugin 'rhysd/vim-clang-format'
Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plugin 'junegunn/fzf.vim'
" all plugins must be added before this line
call vundle#end() " required
filetype plugin indent on " required
" To ignore plugin indent changes, use
"filetype plugin on
"
" all other configuration from this line
syntax enable " enable highlight
colorscheme onehalfdark

let mapleader=" "
let maplocalleader=" "
" fzf needs bat to work properly
let g:fzf_vim={}
let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:fzf_vim.preview_window = ['right,70%', 'ctrl-/']
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.7 } }
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

let g:python_highlight_all = 1
let g:black_linelength = 79 " PEP8

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

set mouse=a
set ttymouse=sgr
set signcolumn=yes " always shown signcolumn
set updatetime=500 " updateime of 500ms
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

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" Use <c-space> to trigger completion
inoremap <silent><expr> <c-@> coc#refresh()
" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

nnoremap <silent> <leader>ff :Files<CR>
nnoremap <silent> <leader><space> :GFiles<CR>
nnoremap <silent> <leader>cm :Commits<CR>
nnoremap <silent> <leader>ft :Filetypes<CR>
nnoremap <silent> <leader>nt :NERDTree<CR>

" automatically close brackets and parenthesis and place cursor inside
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
