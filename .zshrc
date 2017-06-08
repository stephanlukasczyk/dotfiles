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
  zgen oh-my-zsh plugins/zsh-syntax-highlighting

  zgen load zsh-users/zsh-history-substring-search

  zgen load caiogondim/bullet-train-oh-my-zsh-theme bullet-train

  zgen load tarruda/zsh-autosuggestions
  zle -N zle-line-init
  AUTOSUGGESTIONS_HIGHLIGHT_COLOR='fg=8'


  # generate the init script from plugins above
  zgen save
fi

# ______________________________________________
cGrn="190"
cCyn="122"
# # zgen selfupdate
# # setopt correctall
setopt auto_resume
setopt autocd
setopt chase_links	 # resolve symlinks
setopt completeinword
setopt extendedglob
setopt interactivecomments
unsetopt caseglob

# bindkey "^[[A" history-search-backward
# bindkey "^[[B" history-search-forward
cFg="2;38;5;"
# %d	actual text
infoBg=$BG[234];	infoFg=$FG[244];
errBg=$BG[052];		errFg=$FG[160]
zstyle ':completion:::::' completer _complete _approximate
zstyle ':completion:*:approximate:*' max-errors 2

zstyle ':completion:*' format "${infoBg}${infoFg}- [%d]${reset_color}"
# ':completion:function:completer:command:argument:tag'
zstyle ':completion:*' auto-description "$FG[240]specify: %d"
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' group-name ''
# # zstyle ':completion:*' list-colors ''
# zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(*)=='${cFg}${cGrn}'='$cFg'239}:${(s.:.)LS_COLORS}")';
zstyle ':completion:*:aliases' list-colors '=*='$cFg'072'
zstyle ':completion:*:options' list-colors '=(-- *)='$cFg'239'
# zstyle ':completion:*:options' list-colors '=^(-- *)=34'

# zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt "${infoBg}%SAt %p: TAB for more, or the character to insert%s${reset_color}"
# # zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
# zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select=2 eval "$(dircolors -b)"
# zstyle ':completion:*' menu select=2 "{infoBg}${infoFg}"
# # zstyle ':completion:*' menu select=long
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
# zstyle ':completion:*' "select-prompt %SScrolling active: current selection at %p%s"
zstyle ':completion:*' "select-prompt %SScroll %p%s"
# zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
# zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
zstyle ':completion:*:killall:*' command 'ps -u $USER -o cmd'
zstyle ':completion:*:descriptions' format "$FG[094]xxxxxxxx%U%B%d%b%u"
zstyle ':completion:*:messages' format '%B%U---- %d%u%bxxxxxxxx'
zstyle ':completion:*:warnings' format "${errBg}${errFg}%BNo matches for:${reset_color} $FG[052]%d%b${reset_color}"

zstyle ':filter-select:highlight' matched fg=${cGrn}
zstyle ':filter-select:highlight' selected fg=black,bg=${cGrn}
zstyle ':filter-select:highlight' title fg=red
zstyle ':filter-select:highlight' marked fg=red
zstyle ':filter-select' case-insensitive yes
zstyle ':filter-select' extended-search yes
zstyle ':filter-select' rotate-list yes
# # zstyle ":completion:*:commands" rehash 1

bindkey '^R' zaw-history
bindkey '^Q' zaw

HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=cyan,fg=white'
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bg=red,fg=white,bold'
# HISTORY_SUBSTRING_SEARCH_GLOBBING_FLAGS='i'
# # ______________________________________________
# ZSH_HIGHLIGHT_HIGHLIGHTERS=(main root brackets pattern cursor)
for i in brackets main pattern ; do	# line root
	if [[ " ${ZSH_HIGHLIGHT_HIGHLIGHTERS[*]} " != *" $i "* ]]; then ZSH_HIGHLIGHT_HIGHLIGHTERS+=( $i ); fi
done

echo $plugins
ZSH_HIGHLIGHT_PATTERNS+=('ls -rf *' 'fg=white,bold,bg=red')

# ZSH_HIGHLIGHT_STYLES[alias]=fg=white,bold,underline,standout
ZSH_HIGHLIGHT_STYLES[alias]="fg=072"
# ZSH_HIGHLIGHT_STYLES[alias]=fg=white,bold
ZSH_HIGHLIGHT_STYLES[assign]="fg=yellow,bold"
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=009
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=none
ZSH_HIGHLIGHT_STYLES[builtin]=fg=white,bold
ZSH_HIGHLIGHT_STYLES[command]=fg=white,bold
ZSH_HIGHLIGHT_STYLES[commandseparator]=none
ZSH_HIGHLIGHT_STYLES[default]=none
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=magenta
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=none
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=magenta,bold
ZSH_HIGHLIGHT_STYLES[function]=fg=green,bold
ZSH_HIGHLIGHT_STYLES[globbing]=fg=magenta,bold
ZSH_HIGHLIGHT_STYLES[hashed-command]=fg=009
ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=white,underline
ZSH_HIGHLIGHT_STYLES[path]=fg=129
ZSH_HIGHLIGHT_STYLES[precommand]=fg=white,underline
ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=009,standout
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=none
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=005
ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=009
ZSH_HIGHLIGHT_STYLES[path_prefix]=fg=cyan
ZSH_HIGHLIGHT_STYLES[path_approx]=fg=cyan

# ZSH_HIGHLIGHT_STYLES[line]='bold'
# ZSH_HIGHLIGHT_STYLES[root]='bg=red'

# ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]='fg=yellow,bold'
# ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]='fg=234'
ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]="fg=160,bg=052"
# ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]="fg=${infoBg}"
ZSH_HIGHLIGHT_STYLES[bracket-error]='fg=red,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-1]='fg=blue,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-2]='fg=red,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-3]='fg=yellow,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-4]='fg=magenta,bold'

HISTFILE="${HOME}/.zsh_history"
HISTSIZE=5000
SAVEHIST=5000

BULLETTRAIN_TIME_SHOW=false
BULLETTRAIN_STATUS_BG=magenta
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

source "${ZGEN}/caiogondim/bullet-train-oh-my-zsh-theme-master/bullet-train.zsh-theme"

############### Aliases
export EDITOR=vim
alias ...='cd ../..'
alias m='tmux -u2'
#alias vim='vim --servername vim'
alias myip='wget http://checkip.dyndns.org -O - -o /dev/null | cut -d: -f 2 | cut -d\< -f 1'
alias pong='ping -c 3 google.com'
alias weather='curl -4 wttr.in/Passau'

proxy_set_uni() {
  export http_proxy="http://www-cache.rz.uni-passau.de:3128"
  export https_proxy=$http_proxy
  export ftp_proxy=$http_proxy
  export HTTP_PROXY=$http_proxy
  export HTTPS_PROXY=$http_proxy
  export FTP_PROXY=$http_proxy
}
proxy_unset() {
  export http_proxy=""
  export https_proxy=$http_proxy
  export ftp_proxy=$http_proxy
  export HTTP_PROXY=$http_proxy
  export HTTPS_PROXY=$http_proxy
  export FTP_PROXY=$http_proxy
}
screen_set_uni() {
  xrandr --output VIRTUAL1 --off --output DP3 --off --output DP2 --off --output DP1 --off --output HDMI3 --off --output HDMI2 --off --output HDMI1 --mode 1600x1200 --pos 0x0 --rotate left --output LVDS1 --off --output VGA1 --mode 1600x1200 --pos 1200x400 --rotate normal ;
  xrandr --output VIRTUAL1 --off --output DP3 --off --output DP2 --off --output DP1 --off --output HDMI3 --off --output HDMI2 --off --output HDMI1 --mode 1600x1200 --pos 0x0 --rotate left --output LVDS1 --off --output VGA1 --mode 1600x1200 --pos 1200x400 --rotate normal
}
screen_unset_uni() {
  xrandr --output VIRTUAL1 --off --output DP3 --off --output DP2 --off --output DP1 --off --output HDMI3 --off --output HDMI2 --off --output HDMI1 --off --output LVDS1 --mode 1366x768 --rotate normal --output VGA1 --off ;
  xrandr --output VIRTUAL1 --off --output DP3 --off --output DP2 --off --output DP1 --off --output HDMI3 --off --output HDMI2 --off --output HDMI1 --off --output LVDS1 --mode 1366x768 --rotate normal --output VGA1 --off
}

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
