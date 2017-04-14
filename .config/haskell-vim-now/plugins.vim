" Custom plugin loading for haskell-vim-now system

" powerline style status line
"Plug 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}

" Fuzzy completion for file navigation
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Completion for C/C++
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer' }

" Solarized color theme
Plug 'altercation/vim-colors-solarized'

" git stuff
Plug 'tpope/vim-git'
Plug 'airblade/vim-gitgutter'

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
