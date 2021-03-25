" vim:fdm=marker
" Legacy stuff you might see{{{
set nocompatible " Makes compatible with vi. Unsed with vimrc in vim and ignored by neovim.
filetype off     " Legacy settings for filetype detection. Not needed
filetype plugin indent on    " Related to filetype above. Vim-plug deals with this automatically
" }}}

" Look and Feel settings {{{
syntax enable " Enables syntax highlighting
set background=dark " lets Vim know what the background color is
set wildmenu " when opening a file with e.g. :e ~/.vim<TAB> there is a graphical menu of all the matches
set ttyfast " Improves speed on a fast terminal
set lazyredraw " Improves Macro speeds as it wont redraw each invidual step
set updatetime=300 "
" }}}

" Numbers {{{
set number " Show Line Numbers
set numberwidth=4 " Number of colums for line numbers
set ruler " Shows the column and line number
" }}}

" paste mode {{{
nnoremap <F5> :set invpaste paste?<CR>
set pastetoggle=<F5> " Vim paste doesn't work as expected.
set showmode " Displays what mode vim is in
" }}}

" Indentation {{{
set autoindent " Keeps the same indent when starting a new line
set cindent " Smart indenting for c
set smartindent " Does correct indenting for stuff like curly brackets
" }}}

" Folding {{{
" Enable folding
set foldmethod=syntax
set foldlevel=99
" }}}


" Disable all bells and whistles
set noerrorbells visualbell t_vb=

" Tab Options {{{
set shiftwidth=2 " value of line shift when using <<,>>, or ==
set tabstop=2 " Width of tab character
set softtabstop=2 " Number of spaces a tab counts when editing
set expandtab " Inserts softtabstop amount of spaces
" }}}

" Set default encoding to utf-8
set encoding=utf-8
set termencoding=utf-9

" Disable backups and swap files. Most of these are just irritations
set nobackup " Disables Always making a backup file
set nowritebackup " Disables making a backup file when writing
set noswapfile " Swapfiles save writes and prevent dual editing

set ignorecase " Ignore case when searching
set smartcase  " When searching try to be smart about cases
set nohlsearch " Don't highlight search term
set incsearch  " Jumping search

" Always show the status line
set laststatus=2

" Allow copy and paste from system clipboard
set clipboard=unnamed

" Delete characters outside of insert area
set backspace=indent,eol,start

" Use Mouse to Scroll
set mouse=a

" Persistent Undo
" https://medium.com/@sidneyliebrand/vim-tip-persistent-undo-2fc78a2973a7
if has('persistent_undo')
    " define a path to store persistent undo files.
    let target_path = expand('~/.config/vim-persisted-undo/')
    " create the directory and any parent directories
    " if the location does not exist.
    if !isdirectory(target_path)
        call system('mkdir -p ' . target_path)
    endif
    " point Vim to the defined undo directory.
    let &undodir = target_path
    " finally, enable undo persistence.
    set undofile
endif

" Leader key is SPACE, I find it the best
let g:mapleader = " "
let g:maplocalleader = ","

nnoremap <silent><Leader>fh :History<CR>
nnoremap <Leader>fR :source $MYVIMRC<CR>
nnoremap <Leader>fr :e $MYVIMRC<CR>
nnoremap <Leader>fs :w<CR>
nnoremap <Leader>fS :wa<CR>

