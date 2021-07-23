" vim-plug {{{

if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MyVIMRC
endif

call plug#begin('~/.config/nvim/bundle')

" Reset some creepy stuff in VIM to a reasonable base line
Plug 'tpope/vim-sensible'

" Fuzzy completion for file navigation
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Completion plugins
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'deoplete-plugins/deoplete-clang'
Plug 'deoplete-plugins/deoplete-jedi'
Plug 'wellle/tmux-complete.vim'
Plug 'arakashic/chromatica.nvim'
Plug 'scrooloose/syntastic'
Plug 'lervag/vimtex'

" Solarized colour theme
Plug 'altercation/vim-colors-solarized'

" Colourisation of parentheses
Plug 'eapache/rainbow_parentheses.vim'

" Git
Plug 'tpope/vim-fugitive'
Plug 'int3/vim-extradite'
Plug 'tpope/vim-git'
Plug 'airblade/vim-gitgutter'
Plug 'xuyuanp/nerdtree-git-plugin'
Plug 'rhysd/committia.vim'

" Bars, panels, and files
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'ctrlpvim/ctrlp.vim'

" For better writing
Plug 'reedes/vim-wordy'
Plug 'dbmrq/vim-ditto'

" Goyo and Limelight for distraction-freeness and highlight of current paragraph
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

call plug#end()

" }}}

" General {{{

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
if ! exists('mapleader')
  let mapleader=','
endif

if ! exists('g:mapleader')
  let g:mapleader=','
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
nnoremap <BS> <C-w>h

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

" No annoying sounds on errors
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

" Searching red very visible cursor
hi Cursor guibg=red

" Do not blink normal mode cursor
set guicursor=n-v-c:block-Cursor
set guicursor+=n-v-c:blinkon0

set t_Co=256

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Use powerline fonts for airline
if ! exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" airline display buffers at top row
let g:airline#extensions#tabline#enabled=1

let g:airline_powerline_fonts = 1
let g:Powerline_symbols = 'fancy'
let g:airline_symbols.space = "\ua0"

" }}}

" Files, backups, and undo {{{

" Turn backup of, since most stuff is in Git anyway...
set nobackup
set nowb
set noswapfile

" Source the vimrc file after saving it
augroup sourcing
  autocmd!
  autocmd bufwritepost init.vim source $MYVIMRC
augroup END

" Open file prompt with current path
nmap <leader>e :e <C-R>=expand("%:p:h") . '/'<CR>

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
" tabs will be inserted
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

" Copy and paste to OS clipboard
nmap <leader>y "*y
vmap <leader>y "*y
nmap <leader>d "*d
vmap <leader>d "*d
nmap <leader>p "*p
vmap <leader>p "*p

" }}}

" Visual mode related {{{

" Visual mode pressing * or # searches for the current selection
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
        \   exe "normal! g`\"" |
        \ endif
augroup END

" Remember info about open buffers on close
set viminfo^=%

" Open window splits in various places
nmap <leader>sh :leftabove  vnew<CR>
nmap <leader>sl :rightbelow vnew<CR>
nmap <leader>sk :leftabove  new<CR>
nmap <leader>sj :rightbelow new<CR>

" do not close buffers when you are not displaying them
set hidden

" Previous buffer, next buffer
nnoremap <leader>bp :bp<cr>
nnoremap <leader>bn :bn<cr>

" Close every window in current tabview but the current
nnoremap <leader>bo <c-w>o

" Delete buffer without closing pane
noremap <leader>bd :Bd<cr>

" Fuzzing find buffers
noremap <leader>b<space> :CtrlPBuffer<cr>

" }}}

" Status Line {{{

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
    call CmdLine("%s" . '/' . l:patter . '/')
  elseif a:direction == 'f'
    execute "normal /" . l:pattern . "^M"
  endif

  let @/ = l:pattern
  let @" = l:saved_reg
endfunction

" }}}

" NERDTree {{{

" Close nerdtree after a file is selected
let NERDTreeQuiteOnOpen=1

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

" If nerdtree is closed, find current file, if open, close it
nmap <silent> <leader>f <ESC>:call ToggleFindNerd()<CR>
nmap <silent> <leader>F <ESC>:NERDTreeToggle<CR>

let g:NERDTreeGitStatusIndicatorMapCustom = {
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
  " Clean quickfix list
  let qf_list = []
  " Find files committed in HEAD
  let git_output = system("git diff-tree --no-commit-id --name-only -r HEAD\n")
  for committed_file in split(git_output, "\n")
    let qf_item = {'filename': committed_file}
    call add(qf_list, qf_item)
  endfor
  " File quickfix list with them
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
let g:deoplete#enabled_at_startup=1

let g:deoplete#sources#clang#libclang_path="/Library/Developer/CommandLineTools/usr/lib/libclang.dylib"
let g:deoplete#sources#clang#clang_header="/Library/Developer/CommandLineTools/usr/lib/clang"

let g:tmuxcomplete#trigger = ''

let g:chromatica#libclang_path='/Library/Developer/CommandLineTools/usr/lib/libclang.dylib'
let g:chromatica#responsive_mode=1

if &filetype=='text'
  call deoplete#custom#var('omni', 'input_patterns', {
        \ 'tex': g:vimtex#re#deoplete,
        \ })
endif

let g:python_host_prog = '/Users/sl/virtualenvs/neovim2/bin/python'
let g:python3_host_prog = '/Users/sl/virtualenvs/neovim3/bin/python'

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

let g:syntastic_tex_checkers = ['lacheck', 'chktex', 'proselint']
let g:syntastic_mail_checkers = ['proselint']

let g:syntastic_python_python_exec = 'python3'
let g:syntastic_python_checkers = ['python3', 'pylint']

" }}}

" Python {{{

autocmd Filetype py setlocal ts=4 sts=4 sw=4
autocmd Filetype py setlocal textwidth=88
autocmd Filetype py setlocal colorcolumn=89
autocmd Filetype py setlocal formatoptions+=t
autocmd Filetype py match Error /\%81v.\+/
autocmd Filetype pyi setlocal ts=4 sts=4 sw=4
autocmd Filetype pyi setlocal textwidth=88
autocmd Filetype pyi setlocal colorcolumn=89
autocmd Filetype pyi setlocal formatoptions+=t
autocmd Filetype pyi match Error /\%81v.\+/

" autocmd BufWritePre *.py execute ':Black'
nnoremap <F9> :Black<CR>

" }}}

" VimTeX {{{

autocmd Filetype tex setlocal ts=2 sts=2 sw=2
autocmd Filetype tex setlocal textwidth=80
autocmd Filetype tex setlocal colorcolumn=81
autocmd Filetype tex setlocal formatoptions+=1
autocmd Filetype tex match Error /\%81v.\+/
autocmd Filetype plaintex setlocal ts=2 sts=2 sw=2
autocmd Filetype plaintex setlocal textwidth=80
autocmd Filetype plaintex setlocal colorcolumn=81
autocmd Filetype plaintex setlocal formatoptions+=1
autocmd Filetype plaintex match Error /\%81v.\+/
let g:tex_flavor = 'latex'
let g:vimtex_compiler_progname = '/Users/sl/virtualenvs/neovim3/bin/nvr'

let g:vimtex_view_general_viewer = '/Applications/Skim.app/Contents/SharedSupport/displayline'
let g:vimtex_view_general_options = '-r @line @pdf @tex'

nnoremap <leader>lt :VimtexTocToggle<cr>

function! SetServerName()
  let nvim_server_file = "/tmp/curnvimserver.txt"
  let cmd=printf("echo %s > %s", v:servername, nvim_server_file)
  call system(cmd)
endfunction

augroup vimtex_common
  autocmd!
  autocmd FileType tex call SetServerName()
augroup END

" }}}

" Custom mappings {{{

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

vnoremap < <gv
vnoremap > >gv
map <Leader>a ggVG
map <Leader>n :NERDTree<CR>
let NERDTreeShowHidden=1

autocmd Filetype python setlocal completeopt-=preview
autocmd Filetype mail setlocal spell spelllang=de_de textwidth=72

" }}}

" Bindings for fzf-vim {{{

nmap <c-p> :FZF<CR>
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
  let target_pat = '\c'%#\%('.@/.'\)'
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
nmap <Leader>l <plug>(Limelight)

let g:limelight_conceal_ctermfg = 242
let g:limelight_conceal_guifg = '#8a8a8a'
let g:limelight_priority = -1

map <F11> :Goyo <bar> :Limelight!! <CR>

" }}}

" Wordy {{{

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
      \ 'adjectives',
      \ 'adverbs',
      \]

noremap <silent> <F8> :<C-u>NextWordy<cr>
xnoremap <silent> <F8> :<C-u>NextWordy<cr>
inoremap <silent> <F8> <C-o>:NextWordy<cr>
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

