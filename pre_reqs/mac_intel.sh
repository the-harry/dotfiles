#!/bin/sh

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install zsh ctags git hub zellij the_silver_searcher fzf
$(brew --prefix)/opt/fzf/install

brew install macvim -- --with-override-system-vim --with-lua --with-luajit

brew tap homebrew/cask-fonts
brew install --cask atom brave-browser firefox spotify font-fira-code

brew tap heroku/brew && brew install heroku
heroku login -i
