#!/bin/bash
# setup script after cloning the repository

DOTFILEDIR="$( cd "$( dirname $"{BASH_SOURCE[0]}" )" && pwd )"
RED='\033[0;31m'
NC='\033[0m'

# install vim and neovim dependencies
curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

curl -fLo $HOME/.config/nvim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

ln -s "${DOTFILEDIR}/.config/nvim/init.vim" "${HOME}/.vimrc"
mkdir -p "${HOME}/.config/nvim"
ln -s "${DOTFILEDIR}/.config/nvim/init.vim" "${HOME}/.config/nvim/init.vim"

nvim -c 'PlugInstall | qa'
vim -c 'PlugInstall | qa'

# Link configuration files
ln -s "${DOTFILEDIR}/.config/redshift.conf" "${HOME}/.config/redshift.conf"
ln -s "${DOTFILEDIR}/.clang-format" "${HOME}/.clang-format"
ln -s "${DOTFILEDIR}/.gitconfig" "${HOME}/.gitconfig"
ln -s "${DOTFILEDIR}/.i3" "${HOME}/.i3"
ln -s "${DOTFILEDIR}/.i3status.conf" "${HOME}/.i3status.conf"
ln -s "${DOTFILEDIR}/.mutt" "${HOME}/.mutt"
ln -s "${DOTFILEDIR}/.muttrc" "${HOME}/.muttrc"
echo -e "${RED}\tAdd account configuration to ${DOTFILEDIR}/.mutt!${NC}"
ln -s "${DOTFILEDIR}/.notmuch-config" "${HOME}/.notmuch-config"
echo -e "${RED}\tAdd offlineimap configuration to ${HOME}!${NC}"
ln -s "${DOTFILEDIR}/.tmux.conf" "${HOME}/.tmux.conf"
ln -s "${DOTFILEDIR}/.urlview" "${HOME}/.urlview"
ln -s "${DOTFILEDIR}/.xbindkeysrc" "${HOME}/.xbindkeysrc"
ln -s "${DOTFILEDIR}/.XCompose" "${HOME}/.XCompose"
ln -s "${DOTFILEDIR}/.xinitrc" "${HOME}/.xinitrc"
ln -s "${DOTFILEDIR}/.Xresources" "${HOME}/.Xresources"
ln -s "${DOTFILEDIR}/.zshrc" "${HOME}/.zshrc"
ln -s "${DOTFILEDIR}/.zsh.d" "${HOME}/.zsh.d"

echo -e "\n\nFinished!"
