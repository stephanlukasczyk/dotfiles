# powerline
source /usr/share/zsh/site-contrib/powerline.zsh

export ZSH=~/.zsh

# Load all of the config files in ~/.zsh/lib/ that end in .zsh
for config_file ($ZSH/lib/*.zsh) source $config_file

source $ZSH/zsh-autosuggestions/zsh-autosuggestions.zsh
#fpath = ($ZSH/zsh-completions/src $fpath)
source $ZSH/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSH/zsh-history-substring-search/zsh-history-substring-search.zsh

# Load and run compinit
autoload -U compinit
compinit -i
