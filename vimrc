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
Plugin 'joshdick/onedark.vim'
Plugin 'cespare/vim-toml'
Plugin 'vim-python/python-syntax'
Plugin 'bfrg/vim-cpp-modern'
Plugin 'rhysd/vim-clang-format'
Plugin 'rust-lang/rust.vim'
Plugin 'tpope/vim-commentary'
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

let mapleader=" "
let maplocalleader=" "

let g:onedark_color_overrides = {
\ "purple": { "gui": "#e387ff", "cterm": "170", "cterm16": "5" },
\ "green": { "gui": "#8bcd5b", "cterm": "114", "cterm16": "2" },
\ "blue": { "gui": "#6ebeff", "cterm": "39", "cterm16": "4" },
\ "red": { "gui": "#ff6e7a", "cterm": "204", "cterm16": "1" },
\ "dark_red": { "gui": "#BE5046", "cterm": "196", "cterm16": "9" },
\ "yellow": { "gui": "#ffd587", "cterm": "180", "cterm16": "3" },
\ "dark_yellow": { "gui": "#D19A66", "cterm": "173", "cterm16": "11" },
\ "cyan": { "gui": "#66deed", "cterm": "38", "cterm16": "6" },
\ "comment_grey": { "gui": "#5C6370", "cterm": "59", "cterm16": "15" },
\ "gutter_fg_grey": { "gui": "#4B5263", "cterm": "238", "cterm16": "15" },
\ "cursor_grey": { "gui": "#2C323C", "cterm": "236", "cterm16": "8" },
\ "visual_grey": { "gui": "#3E4452", "cterm": "237", "cterm16": "15" },
\ "menu_grey": { "gui": "#3E4452", "cterm": "237", "cterm16": "8" },
\ "special_grey":  { "gui": "#3B4048", "cterm": "238", "cterm16": "15" },
\ "vertsplit": { "gui": "#181A1F", "cterm": "59", "cterm16": "15" },
\ "background": { "gui": "#26282e", "cterm": "235", "cterm16": "NONE" },
\}
colorscheme onedark

" fzf needs bat to work properly
let g:fzf_vim = {}
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

let g:rustfmt_autosave = 1

let g:clang_format#auto_format=1 " enable autoformatting on buffer write
let g:clang_format#detect_style_file=1 " detect and load .clang-format file automatically
let g:clang_format#auto_format_on_insert_leave=1

let g:lightline = {
      \ 'colorscheme': 'onedark',
      \ 'background': 'dark',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'filetype' ],
      \             [ 'filename','gitbranch', 'cocstatus', 'currentfunction', 'readonly', 'modified' ] ],
      \   'right': [ [ 'fileformat'], ['lineinfo', 'percent'] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead',
      \   'filetype': 'MyFileType',
      \   'fileformat': 'MyFileFormat',
      \   'cocstatus': 'coc#status',
      \   'currentfunction': 'CocCurrentFunction', 
      \ },
      \ }

function! MyFileType()
    return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol(): 'no ft'): ''
endfunction

function! MyFileFormat()
    return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

set mouse=a
set ttymouse=sgr
set signcolumn=yes " always shown signcolumn
set updatetime=500 " updateime of 500ms
set t_Co=256 " 256 colors
"" set number " set number
set relativenumber
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
nnoremap <silent> <leader>fg :GFiles<CR>
nnoremap <silent> <leader>cm :Commits<CR>
nnoremap <silent> <leader>ft :Filetypes<CR>
nnoremap <silent> <leader>nt :NERDTree<CR>

nnoremap <silent> vv :vsplit<CR>
nnoremap <silent> hs :split<CR>

nnoremap gh <C-W><C-H>
nnoremap gj <C-W><C-J>
nnoremap gk <C-W><C-K>
nnoremap gl <C-W><C-L>

" automatically close brackets and parenthesis and place cursor inside
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
