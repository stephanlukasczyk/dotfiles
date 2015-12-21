## Automatically start X after login to TTY1
#[[ $(tty) == "/dev/tty1" ]] && exec startx

## smart urls
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

## file rename magick
bindkey "^[m" copy-prev-shell-word

## jobs
setopt long_list_jobs

## pager
export PAGER=less
export LC_CTYPE=$LANG

## editor
export EDITOR=vim

## disable beep on errors
unsetopt beep

## texmf path
export TEXMFLOCAL=/home/sl/.texmf
export TEXMFHOME=/home/sl/.texmf

## term
#export TERM=screen-256color

export XDG_CONFIG_HOME=/home/sl/.config
