#!/bin/bash
cd "$(dirname "$0")"
git pull

# homebrew, vim, zsh
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
curl https://j.mp/spf13-vim3 -L -o - | sh
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | shß

# the rest
function doIt() {
	rsync --exclude ".git/" --exclude ".DS_Store" --exclude "bootstrap.sh" --exclude "README.md" -av . ~
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt
	fi
fi

unset doIt

. ~/.zshrc

# powerline-shell for a pretty CLI
# https://github.com/milkbikis/powerline-shell
git clone git@github.com:milkbikis/powerline-shell.git ~/Code/powerline-shell
cd ~/Code/powerline-shell
./install.py
ln -s /Users/grich/powerline-shell/powerline-shell.py ~/powerline-shell
# fix powerline fonts. todo: programatically change iterm fonts?
cd ~/Code
git clone git@github.com:powerline/fonts.git
