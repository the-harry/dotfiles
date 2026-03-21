#!/bin/sh

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Layer 1: Common tools
brew install zsh ctags git hub zellij the_silver_searcher fzf
$(brew --prefix)/opt/fzf/install

# Layer 2: Arch independent software
brew install macvim -- --with-override-system-vim --with-lua --with-luajit

brew tap homebrew/cask-fonts
brew install --cask atom brave-browser firefox spotify font-fira-code

# Layer 3: Cvinfra
brew tap heroku/brew && brew install heroku
heroku login -i

# Layer 5: Stack flavours
brew install pyenv asdf
