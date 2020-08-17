" vim:fdm=marker
" Legacy stuff you might see{{{
set nocompatible " Makes compatible with vi. Unsed with vimrc in vim and ignored by neovim.
filetype off     " Legacy settings for filetype detection. Not needed
filetype plugin indent on    " Related to filetype above. Vim-plug deals with this automatically
" }}}

" Plugins {{{
" TODO: Keep Plug commands between plug#begin() and plug#end().
call plug#begin()

" Git Plugins
Plug 'airblade/vim-gitgutter'     " Show git diff of lines edited
Plug 'tpope/vim-fugitive'         " :Gblame
Plug 'rhysd/git-messenger.vim'    " Good Git Message Display

" Intellisense Plugins
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'HerringtonDarkholme/yats.vim' " Better Syntax Highlighting
Plug 'pangloss/vim-javascript'    " JavaScript support
Plug 'leafgarland/typescript-vim' " TypeScript syntax
Plug 'maxmellon/vim-jsx-pretty'   " JS and JSX syntax
Plug 'jparise/vim-graphql'        " GraphQL syntax
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }

" FZF great fuzzier searcher
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'           " Set up fzf and fzf.vim

" Key Stroke Display
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }

" Aestetic Plugins
Plug 'vim-airline/vim-airline'    " Vim powerline
Plug 'flazz/vim-colorschemes'
Plug 'ryanoasis/vim-devicons'

" Commenting
Plug 'preservim/nerdcommenter'

call plug#end()              " required
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

" CoC extensions {{{
let g:coc_global_extensions = ['coc-solargraph', 'coc-tsserver', 'coc-json', 'coc-explorer']

" Add CoC Prettier if prettier is installed
if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
endif

" Add CoC ESLint if ESLint is installed
if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extensions += ['coc-eslint']
endif


" Leader key is SPACE, I find it the best
let g:mapleader = " "
let g:maplocalleader = ","

" Show autocomplete when Tab is pressed
inoremap <silent><expr> <Tab> coc#refresh()

" Define prefix dictionary
" NOTE: WhichKey settings must be before something, but I'm not sure what
let g:leader_map =  {}
let g:which_key_sep = ' '
let g:which_key_disable_default_offset = 1
autocmd! User vim-which-key call which_key#register('<Space>', "g:leader_map")
nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>

" Top Level Mappings
" Map Windows
for s:i in range(1, 9)
  let g:leader_map[s:i] = 'window-'.s:i
  let g:leader_map[s:i] = 'which_key_ignore'
endfor
unlet s:i
nnoremap <Leader>' :terminal<CR>
" Commenting
" Default NERDCommenter mappings conflict - so pull them in as needed
let g:NERDCreateDefaultMappings = 0
nmap <leader>/ <plug>NERDCommenterToggle
xmap <leader>/ <plug>NERDCommenterToggle


let g:leader_map['x'] = {
      \ 'name' : '+text',
      \ 'y' :  'yank-&-comment'      ,
      \ 's' :  'sexy-comment'      ,
      \ }
nmap <leader>xy <plug>NERDCommenterYank
xmap <leader>xy <plug>NERDCommenterYank
nmap <leader>xs <plug>NERDCommenterSexy
xmap <leader>xs <plug>NERDCommenterSexy


" Toggle Settings
let g:leader_map['t'] = {
      \ 'name' : '+toggle',
      \ 'n' :  'toggle-line-numbers'      ,
      \ 'p' :  'toggle-paste'      ,
      \ }

" Custom KeyMapping
" Buffer Mappings
let g:leader_map['b'] = {
      \ 'name' : '+buffer'       ,
      \ 'd' :  'delete-buffer'   ,
      \ 'n' :  'next-buffer'     ,
      \ 'p' :  'previous-buffer' ,
      \ 'b' :  'fzf-buffer'      ,
      \ }

for s:i in range(1, 9)
  " <Leader>b[1-9] move to buffer [1-9]
  execute 'nnoremap <Leader>b'.s:i ':b'.s:i.'<CR>'
  let g:leader_map.b[s:i] = 'which_key_ignore'
endfor
unlet s:i
nnoremap <silent><leader>bd :bd<CR>
nnoremap <silent><leader>bn :bn<CR>
nnoremap <silent><leader>bp :bp<CR>
nnoremap <silent><leader>bb :Buffers<CR>

" Code Actions
let g:leader_map['c'] = {
      \ 'name' : '+code-actions'                 ,
      \ 'a' :  'show-actions'            ,
      \ 'd' :  'go-to-definition'        ,
      \ 'f' :  'code-fix'                ,
      \ 'i' :  'go-to-implementation'    ,
      \ 'r' :  'find-references'         ,
      \ 't' :  'go-to-type-definition'   ,
      \ }
nmap <Leader>ca <Plug>(coc-codeaction)
nmap <Leader>cd <Plug>(coc-definition)
nmap <Leader>cf <Plug>(coc-fix-current)
nmap <Leader>ci <Plug>(coc-implementation)
nmap <Leader>cr <Plug>(coc-references)
nmap <Leader>ct <Plug>(coc-type-definition)


" TODO: Errors
let g:leader_map['e'] = {
      \ 'name' : '+errors'     ,
      \ 'n' : 'next-error'     ,
      \ 'p' : 'previous-error' ,
      \ }

" TODO: Git Key Mappings
let g:leader_map['g'] = {
      \ 'name' : '+git/version-control' ,
      \ 'b' : ['Gblame'                 , 'fugitive-blame']             ,
      \ 'c' : ['BCommits'               , 'commits-for-current-buffer'] ,
      \ 'C' : ['Gcommit'                , 'fugitive-commit']            ,
      \ 'd' : ['Gdiff'                  , 'fugitive-diff']              ,
      \ 'e' : ['Gedit'                  , 'fugitive-edit']              ,
      \ 'l' : ['Glog'                   , 'fugitive-log']               ,
      \ 'm' : ['GitMessage'                   , 'git-message']               ,
      \ 'r' : ['Gread'                  , 'fugitive-read']              ,
      \ 's' : ['Gstatus'                , 'fugitive-status']            ,
      \ 'p' : ['Git push'               , 'fugitive-push']              ,
      \ 'a' : ['Git add'                   , 'gid-add-show-diff']                  ,
      \ }

nnoremap <Leader>ga :Git add .<CR>
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gc :Gblame<CR>
nnoremap <Leader>gC :GCommit<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>ge :Gedit<CR>
nnoremap <Leader>gl :Glog<CR>
nnoremap <Leader>gm :GitMessenger<CR>
" Great idea from here:
" https://stackoverflow.com/questions/15407652/how-can-i-run-git-diff-staged-with-fugitive
nnoremap <Leader>gr :Gtabedit! diff --staged<CR>
nnoremap <Leader>gs :Gstatus<CR>

" Register mappings
let g:leader_map['r'] = {}

" File Key Mappings
" Open Recent File
" Get relative filepath
" Open DotFile
" Open File under cursor
let g:leader_map['f'] = {
      \ 'name' : '+files'             ,
      \ 'f' : 'fuzzy-find-file'         ,
      \ 'h' : 'history(recent-files)'         ,
      \ 'r' : 'open-vimrc'                    ,
      \ 'R' : 'reload-vimrc'                    ,
      \ 's' : 'save-file'                       ,
      \ 'S' : 'save-all-files'                       ,
      \ }

nnoremap <silent><Leader>fh :History<CR>
nnoremap <Leader>fR :source $MYVIMRC<CR>
nnoremap <Leader>fr :e $MYVIMRC<CR>
nnoremap <Leader>fs :w<CR>
nnoremap <Leader>fS :wa<CR>

let g:leader_map['s'] = {
      \ 'name' : '+files'             ,
      \ 'b' : 'search-in-buffers'                       ,
      \ 'f' : 'search-for-file'         ,
      \ 's' : 'search-string-in-root',
      \ 'c' : 'search-in-current-file',
      \ }
nnoremap <Leader>sb :Lines<CR>
nnoremap <Leader>sc :BLines<CR>
nnoremap <Leader>sf :GFiles<CR>

" Fuzzy Settings
 "https://github.com/junegunn/fzf.vim/issues/121#issuecomment-546360911
 "Border style (rounded / sharp / horizontal)
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6, 'highlight': 'Todo', 'border': 'rounded' } }
let $FZF_DEFAULT_COMMAND = 'rg --files "!{node_modules/*,.git/*,package-lock}"'

command! -nargs=+ Search :Rg <args>
nnoremap <Leader>ss :Search<space>

" Window Key Mappings
let g:leader_map['w'] = {
      \ 'name' : '+windows' ,
      \ '[h]' : ['<C-W>h'     , 'window-left']           ,
      \ 'j' : ['<C-W>j'     , 'window-below']          ,
      \ 'l' : ['<C-W>l'     , 'window-right']          ,
      \ 'k' : ['<C-W>k'     , 'window-up']             ,
      \ 'q' : ['<C-W>q'     , 'close-window']             ,
      \ '?' : ['Windows'    , 'fzf-window']            ,
      \ }
nnoremap <Leader>wh <c-w>h
nnoremap <Leader>wj <c-w>j
nnoremap <Leader>wk <c-w>k
nnoremap <Leader>wl <c-w>l
nnoremap <Leader>wq <c-w>q
nnoremap <Leader>w? :Windows<CR>


" WhichKey Styling - needed to make terminal distinguished from theme
" TODO: Get these from theme
autocmd FileType which_key highlight WhichKeyFloating ctermfg=252 ctermbg=234

" Theme
colorscheme molokai_dark

" ripgrep
if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
  set grepprg=rg\ --vimgrep
  command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
endif


" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" TODO: WhichKey - Surround with []
" TODO: Better Status Line (bottom)
" TODO: Buffers at top
" TODO: Files Manager (vimfiler) see https://spacevim.org/documentation/ for ideas
" TODO: Yank to clipboard
" TODO: Paste from clipboard
" TODO: Text Manipulation - see spacevim - good stuff like switch camel/snake
" TODO: Window Splits
" TODO: Control Enter to finish line
" TODO: Code Snippets
