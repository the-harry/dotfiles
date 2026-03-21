# Dotfiles

## Source of Inspiration

This project is a fork from [CC Dotfiles](https://github.com/the-harry/dotfiles).

## Pre-Requisites

### Ubuntu / Debian / Kali

* Install `curl`:
  ```sh
  sudo apt-get install -y curl
  ```

### Mac (Intel / M2 / M3 chips)

* Install Homebrew:
  ```sh
  xcode-select --install || xcode-select -r
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  ```
  For Intel Macs, Homebrew installs in `/usr/local`. For Apple Silicon (M2/M3), it installs in `/opt/homebrew`. Follow the instructions on [brew.sh](https://brew.sh/) if not installed.

## Installation

Run the following command:

```sh
sh -c "$(curl -fSs https://raw.githubusercontent.com/the-harry/dotfiles/refs/heads/master/install.sh)"
```

Type your password to change your default shell to `zsh`.

## Post-Installation Steps (Mac Intel / M2 / M3)

* Configure HTTP Proxy:
  ```sh
  export HTTP_PROXY=http://proxy.server.com:portnumber
  ```
  Edit `~/.zshrc` to permanently add this.

* Set up environment variables:
  Edit `~/.dotfiles/zshrc` and add tokens for services like GitHub and 1Password, then reload:
  ```sh
  source ~/.zshrc
  ```

## Documentation

* [Vim Key Mapping](Vim.md)

## Customization

Place your custom configurations in the following files:

* `.aliases.local`
* `.secrets`
* `.zshrc.local`
* `.vimrc.local`
* `.zshenv.local`
* `.plugin.vim.local`
* `.gitconfig.local`
