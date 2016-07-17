" VIM configuration file

set nocompatible  " It's VIM, not VI

" a tab produces a four space indentation
set softtabstop=2
set shiftwidth=2
set textwidth=80
set expandtab
set backspace=indent,eol,start

match ErrorMsg '\s\+$'
nnoremap <Leader>rtw :%s/\s\+$//e<CR>
if exists('+colorcolumn')
    set cc=+1
    highlight ColorColumn ctermbg=lightgrey guibg=lightgrey
else
    au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

set mouse=a
set number
set relativenumber

set laststatus=2
set encoding=utf-8
set t_Co=256

" map leader later used for shortcuts
let mapleader = ","
let maplocalleader = ","

" enable file detection
filetype on
" enable loading the plugin files
filetype plugin on
filetype plugin indent on

" add vundle to rtp
set rtp+=~/.vim/bundle/vundle/
" start vundle
call vundle#rc()

" loading bundles
Bundle 'gmarik/vundle'
Bundle 'ctrlp.vim'
Bundle 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}
Bundle 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Bundle 'junegunn/fzf.vim'
Bundle 'Valloric/YouCompleteMe'
Bundle 'altercation/vim-colors-solarized'
Bundle 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-git'
Bundle 'tpope/vim-dispatch'
Bundle 'jlanzarotta/bufexplorer'
" Bundle 'kien/rainbow_parentheses.vim'
Bundle 'scrooloose/syntastic'
Bundle 'davidhalter/jedi-vim'
Bundle 'lervag/vimtex'
Bundle 'airblade/vim-gitgutter'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'eagletmt/ghcmod-vim'
Plugin 'eagletmt/neco-ghc'
Plugin 'tomtom/tlib_vim'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'garbas/vim-snipmate'
Plugin 'scrooloose/nerdcommenter'
Plugin 'ervandew/supertab'
Plugin 'Shougo/vimproc'


" airline display buffers at top row
let g:airline#extensions#tabline#enabled=1
" enable powerline fonts
let g:airline_powerline_fonts=1
let g:Powerline_symbols='fancy'

" find/grep magic to speedup ctrl-p
let g:ctrlp_user_command='find %s -type f | grep -v -P
    \ "\.git|build\/|\.m4$|\.jpg$|\.png$|\.o$|\.a$|\.so$|\.obj$|\.i$|\.pyc$"
    \ '
map <Leader>t :CtrlP<CR>
" list the files in the current directory
let g:ctrlp_working_path_mode='a'

" vim colors
"let g:solarized_termcolors=256
set background=dark
colorscheme solarized

" highlight syntax in programming languages
syntax on

" disable stupid backup and swap files
set nobackup
set nowritebackup
set noswapfile
set autoread

let g:ycm_path_to_python_interpreter='/usr/bin/python3'
let g:ycm_global_ycm_extra_conf='~/.vim/bundle/YouCompleteMe/.ycm_extra_conf.py'
let g:clang_format#code_style = 'llvm'
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_completion = 0
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_min_num_of_chars_for_completion = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_key_invoke_completion = '<C-Space>'
map <leader>m :Make!<CR>
map <leader>n :Copen<CR>
map <C-K> :pyf /home/sl/.vim/clang-format.py<cr>
imap <C-K> <c-o>:pyf /home/sl/.vim/clang-format.py<cr>
nnoremap <leader>d :YcmCompleter GoToDefinition <CR>
nnoremap <leader>i :YcmCompleter GoToImplementation <CR>
nnoremap <leader>jd :YcmCompleter GoTo<CR>
nnoremap <leader>jt :YcmCompleter GetType<CR>
nnoremap <leader>jp :YcmCompleter GetParent<CR>
nnoremap <F11> :YcmForceCompileAndDiagnostics <CR>
autocmd FileType make set noexpandtab
map <leader>m :Make!<CR>
autocmd FileType cpp let b:dispatch = 'clang++ %'
nnoremap <F9> :Dispatch<CR>
setlocal errorformat=<errorformat-string>

" search options
set hlsearch
set incsearch
set ignorecase
set smartcase

" rainbow parentheses
" au VimEnter * RainbowParenthesesToggle
" au Syntax * RainbowParenthesesLoadRound
" au Syntax * RainbowParenthesesLoadSquare
" au Syntax * RainbowParenthesesLoadBraces
" au Syntax * RainbowParenthesesLoadChevrons
" map <leader>R :RainbowParenthesesToggle

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
map <slient> <Leader>e :Errors<CR>
map <Leader>s :SyntasticToogleMode<CR>

" Haskell
map <silent> tw :GhcModTypeInsert<CR>
map <silent> ts :GhcModSplitFunCase<CR>
map <silent> tq :GhcModType<CR>
map <silent> te :GhcModTypeClear<CR>

" Supertab
let g:SuperTabDefaultCompletionType = '<c-x><c-o>'
if has("gui_running")
  imap <c-space> <c-r>=SuperTabAlternateCompletion("\<lt>c-x>\<lt>c-o>")<cr>
else " no gui
  if has("unix")
    inoremap <Nul> <c-r>=SuperTabAlternateCompletion("\<lr>c-x>\<lr>c-o>")<cr>
  endif
endif
let g:haskellmod_completion_ghc = 1
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
if !exists('g:ycm_semantic_triggers')
  let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers.haskell = ['.']

" tabularize
let g:haskell_tabular = 1
vmap a= :Tabularize /=<CR>
vmap a; :Tabularize /::<CR>
vmap a- :Tabularize /-><CR>

" vimtex
autocmd Filetype tex setlocal ts=2 sts=2 sw=2
autocmd Filetype tex setlocal textwidth=80
autocmd Filetype text setlocal colorcolumn=81
autocmd Filetype tex setlocal formatoptions+=t
autocmd Filetype plaintex setlocal ts=2 sts=2 sw=2
autocmd Filetype plaintex setlocal textwidth=80
autocmd Filetype plaintex setlocal colorcolumn=81
autocmd Filetype plaintex setlocal formatoptions+=t
autocmd Filetype tex match Error /\%81v.\+/
autocmd Filetype plaintex match Error /\%81v.\+/
let g:tex_flavor = 'latex'
if !exists('g:ycm_semantic_triggers')
    let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers.tex = [
    \ 're!\\[A-Za-z]*(ref|cite)[A-Za-z]*([^]]*])?{([^}]*, ?)*'
    \ ]

" From llvm project
augroup csrc
  au!
  autocmd FileType *     set nocindent smartindent
  autocmd FileType c,cpp set cindent
augroup END
set cinoptions=:0,g0,(0,Ws,l1
set smarttab
augroup filetype
  au! BufRead,BufNewFile *Makefile* set filetype=make
augroup END
autocmd FileType make set noexpandtab
command! DeleteTrailingWs :%/\s\+$//
command! Untab :%s/\t/  /g

" Movement
" " =========
" " bind Ctrl+<movement> keys to move around the windows, instead of using
" Leader+w + <movement>
map <Leader>j <c-w>j
map <Leader>k <c-w>k
map <Leader>l <c-w>l
map <Leader>h <c-w>h
map <Leader>w <c-w>w
map <Leader>o <c-w>o
map <Leader>q <c-w>q

map <Leader>, <esc>:tabprevious<CR>
map <Leader>. <esc>:tabnext<CR>

" Custom mappings
" ================
vnoremap < <gv " better indentation
vnoremap > >gv " better indentation
map <Leader>a ggVG " select all
map <Leader>n :NERDTree<CR>
map <F5> :setlocal spell! spelllang=en_us<CR>
map <F6> :setlocal spell! spelllang=de_de<CR>

autocmd FileType python setlocal completeopt-=preview

" git configuration
autocmd Filetype gitcommit setlocal spell spelllang=en_us textwidth=72
autocmd FileType mail setlocal spell spelllang=de_de textwidth=72

" bindings for fzf-vim
nmap <c-p> :FZF<CR>

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Advanced customization using autoload functions
inoremap <expr> <c-x><c-k> fzf#vim#complete#work({'left': '15%'})

" Adds blinking when jumping to the next word
nnoremap <silent> n n:call HLNext(0.4)<CR>
nnoremap <silent> N N:call NLNext(0.4)<CR>

function! HLNext (blinktime)
  highlight WhiteOnRed ctermfg=White ctermbg=Red
  let [bufnum, lnum, col, off] = getpos('.')
  let matchlen = strlen(matchstr(strpart(getline('.'), col-1), @/))
  let target_pat = '\c\%#\%('.@/.'\)'
  let ring = matchadd('WhiteOnRed', target_pat, 101)
  redraw
  exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
  call matchdelete(ring)
  redraw
endfunction
