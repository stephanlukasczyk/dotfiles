" General {{{
" Use indentation for folds
set foldmethod=indent
set foldnestmax=5
set foldlevelstart=99
set foldcolumn=0

augroup vimrcFold
  " fold vimrc itself by categories
  autocmd!
  autocmd FileType vim set foldmethod=marker
  autocmd FileType vim set foldlevel=0
augroup END

" Sets how many lines of history VIM has to remember
set history=700

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it is possible to do extra key combinations
" like <leader>w saves the current file
if ! exists("mapleader")
  let mapleader = ","
endif

if ! exists("g:mapleader")
  let g:mapleader = ","
endif

" Leader key timeout
set tm=2000

" Allow the normal use of "," by pressing it twice
noremap ,, ,

" Use par for prettier line formatting
set formatprg=par
let $PARINIT = 'rTbgqR B=.,?_A_a Q=_s>|'

" Kill the damned Ex mode
nnoremap Q <nop>

" Make <c-h> work like <c-h> again (this is a problem with libterm)
if has('nvim')
  nnoremap <BS> <C-w>h
endif
" }}}

" vim-plug {{{
set nocompatible

" From vim-plug's tips wiki: automatic installation of vim-plug for NeoVIM
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MyVIMRC
endif

if has('nvim')
  call plug#begin('~/.config/nvim/bundle')
else
  call plug#begin('~/.vim/bundle')
endif

" Reset some creepy stuff in VIM to a reasonable base line
Plug 'tpope/vim-sensible'

" Fuzzy completion for file navigation
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Completion plugins
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'zchee/deoplete-clang' " C/C++ completion via clang
Plug 'zchee/deoplete-jedi' " Python completion
Plug 'wellle/tmux-complete.vim' " Tmux completion
Plug 'arakashic/chromatica.nvim' " Clang based syntax highlighting
Plug 'scrooloose/syntastic' " Syntax checking hacks for vim
Plug 'davidhalter/jedi-vim' " Autocompletion library for Python
Plug 'lervag/vimtex' " (La)TeX completion
Plug 'integralist/vim-mypy' " MyPy plugin for Python

" Haskell
Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }
Plug 'enomsg/vim-haskellConcealPlus', { 'for': 'haskell' }
Plug 'eagletmt/ghcmod-vim', { 'for': 'haskell' }
Plug 'eagletmt/neco-ghc', { 'for': 'haskell' }
Plug 'twinside/vim-hoogle', { 'for': 'haskell' }
Plug 'mpickering/hlint-refactor-vim', { 'for': 'haskell' }

" Solarized colour theme
Plug 'altercation/vim-colors-solarized'

" Colourisation of parentheses
Plug 'eapache/rainbow_parentheses.vim'

" Support bundles
Plug 'jgdavey/tslime.vim' " Send command from vim to a running tmux session
Plug 'Shougo/vimproc.vim', { 'do': 'make' } " Interactive command execution
Plug 'ervandew/supertab' " Use Tab for all insert mode completions
Plug 'neomake/neomake' " Asynchronous linting and make framework
Plug 'moll/vim-bbye' " Delete buffers and close files without closing windows
Plug 'nathanaelkane/vim-indent-guides' " Visually display indent levels in code
Plug 'vim-scripts/gitignore' " Set wildignore from gitignore

" Git
Plug 'tpope/vim-fugitive' " git wrapper
Plug 'int3/vim-extradite' " git commit browser, extends fugitive
Plug 'tpope/vim-git' " git runtime files
Plug 'airblade/vim-gitgutter'
Plug 'xuyuanp/nerdtree-git-plugin' " git status in NERDTree
Plug 'rhysd/committia.vim' " more pleasant editing on commit messages

" Bars, panels, and files
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'majutsushi/tagbar'

" Text manipulation
Plug 'vim-scripts/Align' " Help to align text, eqns, declarations, tables, etc.
Plug 'simnalamburt/vim-mundo' " Undo tree visualizer
Plug 'tpope/vim-commentary' " comment stuff out
Plug 'godlygeek/tabular' " Text filtering and alignment
Plug 'easymotion/vim-easymotion' " Vim motions on speed
Plug 'conradirwin/vim-bracketed-paste' " handles paste mode in vim

" Allow pane movement to jump out of vim into tmux
Plug 'christoomey/vim-tmux-navigator'

" For better writing
Plug 'reedes/vim-wordy'
Plug 'dbmrq/vim-ditto'

" Goyo and Limelight for distraction-freeness and highlight of current paragraph
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

call plug#end()
" }}}

" VIM user interface {{{

" Set 7 lines to the cursor—when moving vertically using j/k
set so=7

" Turn on the WiLd menu
set wildmenu
" Tab-complete files up to longest unambiguous prefix
set wildmode=list:longest,full

" Always show current position
set ruler
set number
set relativenumber

" Show trailing whitespace
set list
" But only interesting whitespace
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

match ErrorMsg '\s\+$'
nnoremap <Leader>rtw :%s/\s\+$//e<cr>
if exists('+colorcolumn')
  set cc=+1
  highlight ColorColumn ctermbg=lightgrey guibg=lightgrey
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

" Height of the command bar
set cmdheight=1

" Configure backspace, thus it acts as it should act
set backspace=indent,eol,start
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Do not redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch
" How many thenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set vb t_vb=

if &term =~ '256color'
  set t_ut=
endif

" Force redraw
map <silent> <leader>r :redraw!<CR>

" Turn mouse mode on
nnoremap <leader>ma :set mouse=a<cr>

" Turn mouse mode off
nnoremap <leader>mo :set mouse=<cr>

" Default to mouse mode on
set mouse=a

filetype on
filetype plugin on
filetype plugin indent on
syntax on

" }}}

" Colours and Fonts {{{

try
  colorscheme solarized
  set background=dark
catch
endtry

" Adjust signscolumn to match solarized
hi! link SignColumn LineNr

" Use pleasant but very visible search highlighting
hi Search ctermfg=white ctermbg=173 cterm=none guifg=#ffffff guibg=#e5786d gui=none
hi! link Visual Search

hi Directory guifg=#8ac6f2

" Searing red very visible cursor
hi Cursor guibg=red

" Do not blink normal mode cursor
set guicursor=n-v-c:block-Cursor
set guicursor+=n-v-c:blinkon0

set t_Co=256

" Set utf8 as the standard encoding for vim (neovim has it as default)
if !has('nvim')
  set encoding=utf8
endif

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Use powerline fonts for airline
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" airline display buffers at top row
let g:airline#extensions#tabline#enabled=1

let g:airline_powerline_fonts = 1
let g:Powerline_symbols = 'fancy'
let g:airline_symbols.space = "\ua0"
" }}}

" Files, backups and undo {{{

" Turn backup of, since most stuff is in Git anyway…
set nobackup
set nowb
set noswapfile

" Source the vimrc file after saving it
augroup sourcing
  autocmd!
  if has('nvim')
    autocmd bufwritepost init.vim source $MYVIMRC
  else
    autocmd bufwritepost .vimrc source $MYVIMRC
  endif
augroup END

" Open file prompt with current path
nmap <leader>e :e <C-R>=expand("%:p:h") . '/'<CR>

" Show undo tree
nmap <silent> <leader>u :MundoToggle<CR>

" Fuzzy find files
let g:ctrlp_user_command = 'find %s -type f | grep -v -P
      \ "\.git|build\/|\.m4$|\.jpg$|\.png$|\.o$|\.a$|\.so$|\.obj$|\.i$|\.pyc$"
      \ '
map <Leader>t :CtrlP<CR>
nnoremap <silent> <Leader><space> :CtrlP<CR>
let g:ctrlp_max_files=0
let g:ctrlp_show_hidden=1
let g:ctrlp_custom_ignore = { 'dir': '\v[\/](.git|.cabal-sandbox|.stack-work)$' }
" list the files in the current directory
let g:ctrlp_working_path_mode = 'a'

" }}}

" Text, tab, and indent related {{{

" Use spaces instead of tabs
set expandtab

" 1 tab == 2 spaces, unless the file is already using tabs, in which case
" tabs will be inserted.
set shiftwidth=2
set softtabstop=2
set tabstop=2

" Linebreak on 80 characters
set lbr
set tw=80
set breakindent " break lines visually intended

set ai " Auto indent
set si " Smart indent
set wrap " Wrap lines

" Copy and past to OS clipboard
nmap <leader>y "*y
vmap <leader>y "*y
nmap <leader>d "*d
vmap <leader>d "*d
nmap <leader>p "*p
vmap <leader>p "*p

" }}}

" Visual mode related {{{

" Visual mode pression * or # searches for the current selection
vnoremap <silent> * :call VisualSelection('f', '')<CR>
vnoremap <silent> # :call VisualSelection('b', '')<CR>

" }}}

" Moving around, tabs, windows, and buffers {{{

" Treat long lines as break lines (useful when moving around in them)
nnoremap j gj
nnoremap k gk

noremap <c-h> <c-w>h
noremap <c-k> <c-w>k
noremap <c-j> <c-w>j
noremap <c-l> <c-w>l

" Disable highlight when <leader><cr> is pressed but preserve cursor colouring
nmap <silent> <leader><cr> :noh\|hi Cursor guibg=red<cr>

" Return to last edit position when opening files
augroup last_edit
  autocmd!
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \    exe "normal! g`\"" |
        \ endif
augroup END

" Remember info about open buffers on close
set viminfo^=%

" Open window splits in various places
nmap <leader>sh :leftabove  vnew<CR>
nmap <leader>sl :rightbelow vnew<CR>
nmap <leader>sk :leftabove new<CR>
nmap <leader>sj :rightbelow new<CR>

" Manually create key mappings (to avoid rebinding C-\)
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>

" do not close buffers when you are not displaying them
set hidden

" Previous buffer, next buffer
nnoremap <leader>bp :bp<cr>
nnoremap <leader>bn :bn<cr>

" close every window in current tabview but the current
nnoremap <leader>bo <c-w>o

" delete buffer without closing pane
noremap <leader>bd :Bd<cr>

" fuzzy find buffers
noremap <leader>b<space> :CtrlPBuffer<cr>

" Neovim terminal configurations
if has('nvim')
  " Use <Esc> to escape terminal insert mode
  tnoremap <Esc> <C-\><C-n>
  " make terminal split moving behave like normal neovim
  tnoremap <c-h> <C-\><C-n><C-w>h
  tnoremap <c-j> <C-\><C-n><C-w>j
  tnoremap <c-k> <C-\><C-n><C-w>k
  tnoremap <c-l> <C-\><C-n><C-w>l
endif

" }}}

" Status line {{{

" Always show the status line
set laststatus=2

" }}}

" Editing mappings {{{

" Utility function to delete trailing white space
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc

" }}}

" Spell checking {{{

" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>
map <F5> :setlocal spell! spelllang=en_gb<cr>
map <F6> :setlocal spell! spelllang=de_de<cr>

" }}}

" Helper functions {{{

function! CmdLine(str)
  exe "menu Foo.Bar :" . a:str
  emenu Foo.Bar
  unmenu Foo
endfunction

function! VisualSelection(direction, extra_filter) range
  let l:saved_reg = @"
  execute "normal! vgvy"

  let l:pattern = escape(@", '\\/.*$^~[]')
  let l:pattern = substitute(l:pattern, "\n$", "", "")

  if a:direction == 'b'
    execute "normal ?" . l:pattern . "^M"
  elseif a:direction == 'gv'
    call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*' . a:extra_filter)
  elseif a:direction == 'replace'
    call CmdLine("%s" . '/' . l:pattern . '/')
  elseif a:direction == 'f'
    execute "normal /" . l:pattern . "^M"
  endif

  let @/ = l:pattern
  let @" = l:saved_reg
endfunction

" }}}

" Slime {{{

vmap <silent> <Leader>rs <Plug>SendSelectionToTmux
nmap <silent> <Leader>rs <Plug>NormalModeSendToTmux
nmap <silent> <Leader>rv <Plug>SetTmuxVars

" }}}

" NERDTree {{{

" Close nerdtree after a file is selected
let NERDTreeQuitOnOpen = 1

function! IsNERDTreeOpen()
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

function! ToggleFindNerd()
  if IsNERDTreeOpen()
    exec ':NERDTreeToggle'
  else
    exec ':NERDTreeFind'
  endif
endfunction

" If nerd tree is closed, find current file, if open, close it
nmap <silent> <leader>f <ESC>:call ToggleFindNerd()<CR>
nmap <silent> <leader>F <ESC>:NERDTreeToggle<CR>

let g:NERDTreeIndicatorMapCustom = {
      \ "Modified"  : "✹",
      \ "Staged"    : "✚",
      \ "Untracked" : "✭",
      \ "Renamed"   : "➜",
      \ "Unmerged"  : "═",
      \ "Deleted"   : "✖",
      \ "Dirty"     : "✗",
      \ "Clean"     : "✔︎",
      \ "Ignored"   : "☒",
      \ "Unknown"   : "?"
      \ }

map <C-n> :NERDTreeToggle<CR>

" }}}

" Alignment {{{

" Stop Align plugin from forcing its mappings on us
let g:loaded_AlignMapsPlugin=1
" Align on equal signs
map <Leader>a= :Align =<CR>
" Align on commas
map <Leader>a, :Align ,<CR>
" Align on pipes
map <Leader>a<bar> :Align <bar><CR>
" Prompt for align character
map <leader>ap :Align

" }}}

" Tags {{{

map <leader>tt :TagbarToggle<CR>
set tags=tags;/
set cst
set csverb

" }}}

" Git {{{

let g:extradite_width = 60
" Hide messy Ggrep output and copen automatically
function! NonintrusiveGitGrep(term)
  execute "copen"
  " Map 't' to open selected item in new tab
  execute "nnoremap <silent> <buffer> t <C-W><CR><C-W>T"
  execute "silent! Ggrep " . a:term
  execute "redraw!"
endfunction

command! -nargs=1 GGrep call NonintrusiveGitGrep(<q-args>)
nmap <leader>gs :Gstatus<CR>
nmap <leader>gg :copen<CR>:GGrep
nmap <leader>gl :Extradite!<CR>
nmap <leader>gd :Gdiff<CR>
nmap <leader>gb :Gblame<CR>

function! CommittedFiles()
  " Clear quickfix list
  let qf_list = []
  " Find files committed in HEAD
  let git_output = system("git diff-tree --no-commit-id --name-only -r HEAD\n")
  for committed_file in split(git_output, "\n")
    let qf_item = {'filename': committed_file}
    call add(qf_list, qf_item)
  endfor
  " Fill quickfix list with them
  call setqflist(qf_list)
endfunction

" Show list of last-committed files
nnoremap <silent> <leader>g? :call CommittedFiles()<CR>:copen<CR>

autocmd FileType gitcommit setlocal spell spelllang=en_gb textwidth=72

" }}}

" Completion {{{

set completeopt+=longest

" Use buffer words as default tab completion
let g:SuperTabDefaultCompletionType = '<c-x><c-p>'

" Use deoplete
let g:deoplete#enable_at_startup=1

let g:deoplete#sources#clang#libclang_path="/usr/lib64/llvm/7/lib64/libclang.so"
let g:deoplete#sources#clang#clang_header="/usr/lib64/clang"

let g:tmuxcomplete#trigger = ''

let g:chromatica#libclang_path='/usr/lib64/llvm/7/lib64/libclang.so'
"let g:chromatica#enable_at_startup=1
let g:chromatica#responsive_mode=1

if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif
if &filetype=='tex'
  let g:deoplete#omni#input_patterns.tex=g:vimtex#re#deoplete
endif

let g:python_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python3'

" }}}

" Rainbox parentheses {{{

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
au Syntax * RainbowParenthesesLoadChevrons
map <leader>R :RainbowParenthesesToggle<cr>

" }}}

" Syntastic {{{

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_error_symbol = '☢'
let g:syntastic_warning_symbol = '⚡'
let g:syntastic_style_error_symbol = '☛'
let g:syntastic_style_warning_symbol = '☞'
let g:syntastic_aggregate_errors = 1
let g:syntastic_enable_balloons = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_cpp_check_header = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
map <silent> <Leader>e :Errors<cr>
map <Leader>s :SyntasticToggleMode<cr>

" }}}

" VimTeX {{{

autocmd Filetype tex setlocal ts=2 sts=2 sw=2
autocmd Filetype tex setlocal textwidth=80
autocmd Filetype tex setlocal colorcolumn=81
autocmd Filetype tex setlocal formatoptions+=t
autocmd Filetype plaintex setlocal ts=2 sts=2 sw=2
autocmd Filetype plaintex setlocal textwidth=80
autocmd Filetype plaintex setlocal colorcolumn=81
autocmd Filetype plaintex setlocal formatoptions+=t
autocmd Filetype tex match Error /\%81v.\+/
autocmd Filetype plaintex match Error /\%81v.\+/
let g:tex_flavor = 'latex'

" }}}

" Movement {{{

" bind Ctrl+<movement> keys to move around the windows, instead of using
" Leader+w <movement>

map <Leader>j <c-w>j
map <Leader>k <c-w>k
map <Leader>l <c-w>l
map <Leader>h <c-w>h
map <Leader>w <c-w>w
map <Leader>o <c-w>o
map <Leader>q <c-w>q

map <Leader>, <esc>:tabprevious<cr>
map <Leader>. <esc>:tabnext<cr>

" }}}

" Custom Mappings {{{

vnoremap < <gv " better indentation
vnoremap > >gv " better indentation
map <Leader>a ggVG " select all
map <Leader>n :NERDTree<cr>
let NERDTreeShowHidden=1

autocmd Filetype python setlocal completeopt-=preview
autocmd Filetype mail setlocal spell spelllang=de_de textwidth=72

map <C-I> :pyf /usr/lib64/llvm/6/share/clang/clang-format.py<cr>
imap <C-I> <c-o> :pyf /usr/lib64/llvm/6/share/clang/clang-format.py<cr>

nnoremap <silent> <leader>g :FloatIt<CR>

" }}}

" Bindings for fzf-vim {{{

nmap <c-p> :FZF<cr>
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)
inoremap <expr> <c-x><c-k> fzf#vim#complete#work({'left': '15%'})
nmap <c-x><c-b> :Buffers<CR>

" }}}

" Add blinking when jumping to next word for search {{{

nnoremap <silent> n n:call HlNext(0.2)<cr>
nnoremap <silent> N N:call HlNext(0.2)<cr>

function! HlNext (blinktime)
  highlight WhiteOnRed ctermfg=White ctermbg=Red
  let [bufnum, lnum, col, off] = getpos('.')
  let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
  let target_pat = '\c\%#\%('.@/.'\)'
  let ring = matchadd('WhiteOnRed', target_pat, 101)
  redraw
  exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
  call matchdelete(ring)
  redraw
endfunction

" Delete trailing whitespace and tabs at the end of each line
command! DeleteTrailingWs :%s/\s\+$//

" Convert all tab characters to two spaces
command! Untab :%s/\t/  /g

" }}}

" wordy {{{

let g:wordy#ring = [
      \ 'weak',
      \ ['being', 'passive-voice', ],
      \ 'business-jargon',
      \ 'weasel',
      \ 'puffery',
      \ ['problematic', 'redundant', ],
      \ ['colloquial', 'idiomatic', 'similies', ],
      \ 'art-jargon',
      \ ['contractions', 'opinion', 'vague-time', 'said-synonyms', ],
      \ ]
nnoremap <silent> K :NextWordy<cr>
if !&wildcharm | set wildcharm=<C-z> | endif
execute 'nnoremap <leader>w :Wordy<space>'.nr2char(&wildcharm)

" }}}

" Ditto {{{

au Filetype markdown,text,tex DittoOn
nmap <leader>di <Plug>ToggleDitto
nmap =d <Plug>DittoNext
nmap -d <Plug>DittoPrev
nmap +d <Plug>DittoGood
nmap _d <Plug>DittoBad
nmap ]d <Plug>DittoMore
nmap [d <Plug>DittoLess

" }}}

" Haskell {{{

" Use same colour behind concealed unicode characters
hi clear Conceal

" Pretty unicode haskell symbols
let g:haskell_conceal_wide = 1
let g:haskell_conceal_enumerations = 1
let hscoptions="𝐒𝐓𝐄𝐌xRtB𝔻w"

set tags+=codex.tags;/

let g:tagbar_type_haskell = {
    \ 'ctagsbin'  : 'hasktags',
    \ 'ctagsargs' : '-x -c -o-',
    \ 'kinds'     : [
        \ 'm:modules:0:1',
        \ 'd:data: 0:1',
        \ 'd_gadt: data gadt:0:1',
        \ 't:type names:0:1',
        \ 'nt:new types:0:1',
        \ 'c:classes:0:1',
        \ 'cons:constructors:1:1',
        \ 'c_gadt:constructor gadt:1:1',
        \ 'c_a:constructor accessors:1:1',
        \ 'ft:function types:1:1',
        \ 'fi:function implementations:0:1',
        \ 'o:others:0:1'
    \ ],
    \ 'sro'       : '.',
    \ 'kind2scope': {
        \ 'm' : 'module',
        \ 'c' : 'class',
        \ 'd' : 'data',
        \ 't' : 'type'
    \ },
    \ 'scope2kind': {
        \ 'module' : 'm',
        \ 'class'  : 'c',
        \ 'data'   : 'd',
        \ 'type'   : 't'
    \ }
\ }

" Generate haskell tags with codex and hscope
map <leader>tg :!codex update --force<CR>:call system("git-hscope -X TemplateHaskell")<CR><CR>:call LoadHscope()<CR>

set csprg=hscope
set csto=1 " search codex tags first

nnoremap <silent> <C-\> :cs find c <CR>=expand("<cword>")<CR><CR>
" Automatically make cscope connections
function! LoadHscope()
  let db = findfile("hscope.out", ".;")
  if (!empty(db))
    let path = strpart(db, 0, match(db, "/hscope.out$"))
    set nocsopeverbose " suppress 'duplicate connection' error
    exe "cs add " . db . " " . path
    set cscopeverbose
  endif
endfunction
au BufEnter /*.hs call LoadHscope()

" Hoogle the word under the cursor
nnoremap <silent> <leader>hh :Hoogle<CR>

" Hoogle and prompt for input
nnoremap <leader>hH :Hoogle

" Hoogle for detailed documentation (e.g. "Functor")
nnoremap <leader>hI :HoogleInfo

" Hoogle, close the Hoogle window
nnoremap <silent> <leader>hz :HoogleClose<CR>

" Use hindent instead of par for haskell buffers
autocmd FileType haskell let &formatprg="hindent --tab-size 2 -XQuasiQuotes"

" Enable some tabular presets for Haskell
let g:haskell_tabular = 1

" Delete trailing white space on save
augroup whitespace
  autocmd!
  autocmd BufWrite *.hs :call DeleteTrailingWS()
augroup END

" Completion, Syntax check, Lint & Refactor
augroup haskell
  autocmd!
  autocmd FileType haskell map <silent> <leader><cr> :noh<cr>:GhcModTypeClear<cr>
  autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
augroup END

" Provide (neco-ghc) omnicompletion
if has("gui_running")
  imap <c-space> <c-r>=SuperTabAlternateCompletion("\<lt>c-x>\<lt>c-o>")<cr>
else
  if has("unix")
    inoremap <Nul> <c-r>=SuperTabAlternateCompletion("\<lt>c-x>\<lt>c-o>")<cr>
  endif
endif

" Disable hlint-refactor-vim's default keybindings
let g:hlintRefactor#disableDefaultKeybindings = 1

"hlint-refactor-vim keybindings
map <silent> <leader>hr :call ApplyOneSuggestion()<CR>
map <silent> <leader>hR :call ApplyAllSuggestions()<CR>

" Show types in completion suggestions
let g:necoghc_enable_detailed_browse = 1
" Resolve ghcmod base directory
au FileType haskell let g:ghcmod_use_basedir = getcwd()

" Type of expression under cursor
nmap <silent> <leader>ht :GhcModType<CR>
" Insert type of expression under cursor
nmap <silent> <leader>hT :GhcModTypeInsert<CR>
" GHC errors and warnings
nmap <silent> <leader>hc :Neomake ghcmod<CR>

" open the neomake error window automatically when an error is found
let g:neomake_open_list = 2

" Fix path issues
let s:default_path = escape(&path, '\ ')
" Always add the current file's directory to the path and tags list if not
" already there.  Add it to the beginning to speed up searches.
autocmd BufRead *
      \ let s:tempPath=escape(escape(expand("%:p:h"), ' '), '\ ') |
      \ exec "set path-=".s:tempPath |
      \ exec "set path-=".s:default_path |
      \ exec "set path^=".s:tempPath |
      \ exec "set path^=".s:default_path

" Haskell Lint
nmap <silent> <leader>hl :Neomake hlint<CR>

" Options for Haskell Syntax Check
let g:neomake_haskell_ghc_mod_args = '-g-Wall'

" Point Conversion

function! Pointfree()
  call setline('.', split(system('pointfree '.shellescape(join(getline(a:firstline, a:lastline), "\n"))), "\n"))
endfunction
vnoremap <silent> <leader>h. :call Pointfree()<CR>

function! Pointful()
  call setline('.', split(system('pointful '.shellescape(hoin(getline(a:firstline, a:lastline), "\n"))), "\n"))
endfunction
vnoremap <silent> <leader>h> :call Pointful()<CR>

" }}}

" Goyo {{{

function! s:goyo_enter()
  let b:quitting = 0
  let b:quitting_bang = 0
  autocmd QuitPre <buffer> let b:quitting = 1
  cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
endfunction

function! s:goyo_leave()
  " Quit Vim if this is the only remaining buffer
  if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
    if b:quitting_bang
      qa!
    else
      qa
    endif
  endif
endfunction

autocmd! User GoyoEnter call <SID>goyo_enter()
autocmd! User GoyoLeave call <SID>goyo_leave()

" }}}
" Limelight {{{

nmap <Leader>l <Plug>(Limelight)
xmap <Leader>l <plug>(Limelight)

let g:limelight_conceal_ctermfg = 250
let g:limelight_conceal_guifg = '#8a8a8a'
let g:limelight_priority = -1

map <F11> :Goyo <bar> :Limelight!! <CR>

" }}}
