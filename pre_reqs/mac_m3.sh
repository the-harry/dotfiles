#!/bin/sh

rm -rf "/usr/local/Homebrew/Library/Taps/homebrew/homebrew-core"
brew tap homebrew/core

git -C $(brew --repo homebrew/core) checkout master

# Layer 1: Common tools
brew install zsh zsh-syntax-highlighting ctags tmux \
             reattach-to-user-namespace the_silver_searcher fzf macvim \
             mysql shared-mime-info gpg imagemagick watchman jq \
             ngrok/ngrok/ngrok #poppler
$(brew --prefix)/opt/fzf/install

# Layer 2: Arch independent software
brew tap homebrew/cask-fonts
brew install --cask font-fira-code

# Layer 3: Cvinfra
brew tap heroku/brew && brew install heroku
heroku autocomplete

# Layer 5: Stack flavours
brew install pyenv asdf

sudo chown -R "$USER" /private/tmp/
