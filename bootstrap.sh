#!/bin/bash
cd "$(dirname "$0")"
git pull

# homebrew, vim, zsh
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
curl https://j.mp/spf13-vim3 -L -o - | sh
curl -L http://install.ohmyz.sh | sh

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