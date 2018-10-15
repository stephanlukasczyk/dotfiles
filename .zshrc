export ZSH=~/.zsh
export ZGEN=~/.zgen
export PATH=~/.local/bin:$PATH

setxkbmap -option caps:escape
xmodmap -e 'keysym F12 = Multi_key'

# load zgen
source "${ZSH}/zgen/zgen.zsh"

# if the init script does not exists
if ! zgen saved; then

  # specify plugins here
  zgen oh-my-zsh
  zgen oh-my-zsh plugins/autojump
  zgen oh-my-zsh plugins/colorize
  zgen oh-my-zsh plugins/command-not-found
  zgen oh-my-zsh plugins/common-aliases
  zgen oh-my-zsh plugins/compleat
  zgen oh-my-zsh plugins/cp
  zgen oh-my-zsh plugins/dircycle
  zgen oh-my-zsh plugins/dirhistory
  zgen oh-my-zsh plugins/dirpersist
  zgen oh-my-zsh plugins/extract
  zgen oh-my-zsh plugins/fasd
  zgen oh-my-zsh plugins/frontend-search
  zgen oh-my-zsh plugins/git
  zgen oh-my-zsh plugins/github
  zgen oh-my-zsh plugins/gnu-utils
  zgen oh-my-zsh plugins/history
  zgen oh-my-zsh plugins/history-substring-search
  zgen oh-my-zsh plugins/iwhois
  zgen oh-my-zsh plugins/pip
  zgen oh-my-zsh plugins/profiles
  zgen oh-my-zsh plugins/python
  zgen oh-my-zsh plugins/systemadmin
  zgen oh-my-zsh plugins/themes
  zgen oh-my-zsh plugins/tmux
  zgen oh-my-zsh plugins/urltools

  zgen load arialdomartini/oh-my-git
  zgen load hchbaw/list-colors.zsh
  zgen load sorin-ionescu/prezto
  zgen load thrig/zsh-compdef
  zgen load zsh-users/zsh-completions
  zgen load zsh-users/zsh-completions src
  zgen load http://git.code.sf.net/p/zsh/code Completion/Linux/Command
  zgen load Vifon/deer
  zgen load joel-porquet/zsh-dircolors-solarized
  zgen load zsh-users/zaw
  zgen load clvv/fasd
  zgen load psprint/zsh-navigation-tools

  zgen load zsh-users/zsh-syntax-highlighting
  zgen load trapd00r/zsh-syntax-highlighting-filetypes

  zgen load zsh-users/zsh-history-substring-search

  zgen load stephanlukasczyk/sobole-zsh-theme

  zgen load tarruda/zsh-autosuggestions
  zle -N zle-line-init

  zmodload zsh/complist

  # generate the init script from plugins above
  zgen save
fi

# ______________________________________________

setopt auto_resume
setopt autocd
setopt chase_links   # resolve symlinks
setopt completeinword
setopt complete_in_word
setopt extendedglob
setopt interactivecomments
unsetopt caseglob

bindkey '^R' zaw-history
bindkey '^Q' zaw

HISTFILE="${HOME}/.zsh_history"
HISTSIZE=5000
SAVEHIST=5000

DISABLE_AUTO_TITLE="true"

setopt APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt NO_HIST_BEEP
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS

# ______________________________________________[zaw]
function zaw-src-fuzzy() {
  OLDIFS=$IFS
  IFS=$'\n'
  candidates=($(find .))
  candidates=(${(iou)candidates[@]})
  IFS=$OLDIFS
  unset OLDIFS
  # Define what kind of action can be performed on the selected item
  # first: accept-line
  # second: accept-search
  actions=("zaw-callback-execute" "zaw-callback-append-to-buffer")
  act_descriptions=("execute" "append to edit buffer")
}
zaw-register-src -n fuzzy zaw-src-fuzzy

function fuzzy-start { kill-line; zaw-fuzzy }
zle -N fuzzy-start
bindkey '^F' fuzzy-start
# ----------------------------
bindkey -M filterselect '^M' accept-search
# ______________________________________________

function exists { which $1 &> /dev/null }

autoload -U compinit
compinit -i

zstyle ':completion:*' completer _complete _prefix
zstyle ':completion:*' add-space true

# Smart case matching && match inside filenames
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
# 'm:{a-z}={A-Z}'
# zstyle ':completion:*' matcher-list '' '' 'l:|=* r:|=*' 'l:|=* r:|=*'

zstyle ':completion:*:*:*:*:*' menu select

# Rehash when completing commands
zstyle ":completion:*:commands" rehash 1

# Process completion shows all processes with colours
zstyle ':completion:*:*:*:*:processes' menu yes select
zstyle ':completion:*:*:*:*:processes' force-list always
zstyle ':completion:*:*:*:*:processes' command 'ps -A -o pid,user,cmd'
zstyle ':completion:*:*:*:*:processes' list-colors "=(#b) #([0-9]#)*=0=${color[green]}"
zstyle ':completion:*:*:kill:*:processes' command 'ps --forest -e -o pid,user,tty,cmd'
# zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

# List all processes for killall
zstyle ':completion:*:processes-names' command "ps -eo cmd= | sed 's:\([^ ]*\).*:\1:;s:\(/[^ ]*/\)::;/^\[/d'"

# SSH usernames
if [[ -f ~/.ssh/config ]]; then
  _accounts=(`egrep "^User" ~/.ssh/config | sed s/User\ // | egrep -v '^\*$'`)
  zstyle ':completion:*:users' users $_accounts
fi

# Colours in completion
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# Display message when no matches are found
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'

# Ignore internal zsh functions
zstyle ':completion:*:functions' ignored-patterns '_*'

# Grouping for completion types (trial)
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:descriptions' format "%{$fg_bold[magenta]}%}= %d =%{$reset_color%}"
# zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*' group-name ""

# Speedup path completion
zstyle ':completion:*' accept-exact '*(N)'

# Cache expensive completions
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.cache/zsh

# Load extra completion
for f in `ls ~/.zsh/completion/*.zsh`; do source $f; done


source "${ZGEN}/stephanlukasczyk/sobole-zsh-theme-master/sobole.zsh-theme"
SOBOLE_THEME_MODE="dark"
SOBOLE_DEFAULT_USER="lukasczy"

############### Aliases
export EDITOR=/home/lukasczy/.local/bin/nvim
alias ...='cd ../..'
alias m='tmux -u2'
#alias vim="nvim --cmd \"let g:server_addr = serverstart('vim')\""
alias myip='wget http://checkip.dyndns.org -O - -o /dev/null | cut -d: -f 2 | cut -d\< -f 1'
alias pong='ping -c 3 google.com'
alias weather='curl -4 wttr.in/Passau'
alias mux="tmuxinator"

extract() {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)  tar xjvf $1   ;;
      *.tar.gz)   tar xvzf $1   ;;
      *.tar.xz)   tar xvJf $1   ;;
      *.bz2)      bunzip2 $1    ;;
      *.rar)      unrar $1      ;;
      *.gz)       gunzip $1     ;;
      *.tar)      tar xvf $1    ;;
      *.tbz2)     tar xvjf $1   ;;
      *.tgz)      tar xvzf $1   ;;
      *.zip)      unzip $1      ;;
      *.z)        uncompress $1 ;;
      *.7z)       7z x $1       ;;
      *.xz)       unxz $1       ;;
      *.exe)      cabextract $1 ;;
      *)          echo "\`$1': unrecognized file compression" ;;
    esac
  else
    echo "\`$1' is not a valid file"
  fi
}

cpf() { cp "$@" && goto "$_"; }
mvf() { cp "$@" && goto "$_"; }
goto() { [ -d "$1" ] && cd "$1" || cd "$(dirname "$1")"; }
mkcd() { mkdir -p "$@" && cd "$@"; }

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
fpath=(~/.zsh.d/ $fpath)
