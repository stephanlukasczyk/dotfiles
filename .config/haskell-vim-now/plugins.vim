" Custom plugin loading for haskell-vim-now system

" Fuzzy completion for file navigation
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Completiong plugins
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'zchee/deoplete-clang'
Plug 'zchee/deoplete-jedi'
Plug 'zchee/deoplete-zsh'
Plug 'fszymanski/deoplete-abook'
Plug 'wellle/tmux-complete.vim'
Plug 'arakashic/chromatica.nvim'

" Solarized color theme
Plug 'altercation/vim-colors-solarized'

" Reset some creepy stuff in VIM to reasonable base line
Plug 'tpope/vim-sensible'

" git stuff
Plug 'tpope/vim-git'
Plug 'airblade/vim-gitgutter'
Plug 'Xuyuanp/nerdtree-git-plugin'

" fancy git commit style
Plug 'rhysd/committia.vim'

" coloring of parentheses
Plug 'eapache/rainbow_parentheses.vim'

" syntax checking hacks for vim
Plug 'scrooloose/syntastic'

" autocompletion library especially for Python
Plug 'davidhalter/jedi-vim'

" (La)TeX plugin
Plug 'lervag/vimtex'

" for better writing :)
Plug 'reedes/vim-wordy'
Plug 'dbmrq/vim-ditto'

" syntax highlighting for CPAchecker's specification automaton syntax
Plug 'stephanlukasczyk/vim-syntax-specautomata'

Plug 'keith/tmux.vim'

" vim-orgmode related plugins
Plug 'jceb/vim-orgmode'
Plug 'vim-scripts/utl.vim'
Plug 'tpope/vim-repeat'
Plug 'vim-scripts/taglist.vim'
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-speeddating'
Plug 'mattn/calendar-vim'
Plug 'vim-scripts/SyntaxRange'
