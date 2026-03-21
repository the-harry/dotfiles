#!/bin/sh

install_docker() {
  sudo apt-get remove docker docker-engine docker.io containerd runc
  sudo apt-get update
  sudo apt-get install \
      apt-transport-https \
      ca-certificates \
      curl \
      gnupg2 \
      software-properties-common
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo apt-key fingerprint 0EBFCD88

  sudo add-apt-repository \
     "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
     $(lsb_release -cs) \
     stable"

  sudo apt-get update
  sudo apt-get install docker-ce docker-ce-cli containerd.io
  sudo usermod -aG docker $USER
  sudo docker run hello-world
}

install_docker_compose() {
  sudo apt-get remove docker-compose
  sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
  sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
  which docker-compose
  docker-compose -v
}

install_k8s() {
  curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
  echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
  sudo apt-get update
  sudo apt-get install -y kubelet kubeadm kubectl

  # gcloud container clusters list
  # gcloud container clusters get-credentials CLUSTER --region=REGION
}

install_spotify() {
  curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add -
  echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
  sudo apt-get update && sudo apt-get install spotify-client
}

install_brave() {
  sudo apt install apt-transport-https curl
  sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
  echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
  sudo apt update
  sudo apt install brave-browser
}

install_fzf() {
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install
}

install_zellij() {
  ZELLIJ_VERSION="0.39.2"  # Check latest version
  ZELLIJ_SOURCE_FILE="zellij-x86_64-unknown-linux-musl.tar.gz"
  ZELLIJ_URL="https://github.com/zellij-org/zellij/releases/download/v${ZELLIJ_VERSION}/${ZELLIJ_SOURCE_FILE}"

  echo "Installing zellij ${ZELLIJ_VERSION}"
  wget $ZELLIJ_URL
  tar -xf $ZELLIJ_SOURCE_FILE
  sudo mv zellij /usr/local/bin/
  rm $ZELLIJ_SOURCE_FILE
}

install_gnome_terminal_colors() {
  GIT_REPO="https://github.com/Anthony25/gnome-terminal-colors-solarized.git"
  COLORS_PATH="$HOME/.gnome-terminal-colors-solarized"

  [ -d $COLORS_PATH ] && return

  git clone $GIT_REPO $COLORS_PATH
  $COLORS_PATH/install.sh
}

install_atom() {
  curl -fsSLo ~/Downloads/atom.deb https://atom.io/download/deb
  sudo dpkg -i ~/Downloads/atom.deb
  sudo apt install -f
  sudo dpkg -i ~/Downloads/atom.deb
  rm -f ~/Downloads/atom.deb
}

install_heroku() {
  curl https://cli-assets.heroku.com/install-ubuntu.sh | sh
  heroku login -i
}

install_aws() {
  curl -fsSLo ~/awscliv2.zip "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip"
  unzip ~/awscliv2.zip
  cd ~ && sudo ./aws/install && cd -
  rm -f ~/awscliv2.zip

  curl -fsSLo session-manager-plugin.deb "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb"
  sudo dpkg -i session-manager-plugin.deb
  sudo apt install -f
  sudo dpkg -i session-manager-plugin.deb
  rm -f session-manager-plugin.deb
}

install_gcp() {
  echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
  sudo apt-get install apt-transport-https ca-certificates gnupg
  curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
  sudo apt-get update && sudo apt-get install google-cloud-sdk
  sudo chown -R $USER:$USER ~/.config/gcloud
  gcloud init

  wget https://dl.google.com/cloudsql/cloud_sql_proxy.linux.amd64 -O ~/cloud_sql_proxy
  chmod +x ~/cloud_sql_proxy
}

install_dbeaver() {
  curl -fsSLo ~/Downloads/dbeaver.deb "https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb"
  sudo dpkg -i ~/Downloads/dbeaver.deb
  sudo apt install -f
  sudo dpkg -i ~/Downloads/dbeaver.deb
  rm -f ~/Downloads/dbeaver.deb
}

remove_manual_ruby_install() {
  sudo apt-get remove -y ruby
  sudo apt-get autoremove -y
}

setup_wallpaper() {
  gsettings set org.gnome.desktop.background picture-uri file:///$HOME/.dotfiles/wallpaper.jpg
}

install_fira_code_font() {
  sudo add-apt-repository universe
  sudo apt-get update
  sudo apt install fonts-firacode
}

install_jmeter() {
  sudo apt-get purge openjdk-\*
  sudo apt install openjdk-9-jre && sudo apt install openjdk-9-jdk
  curl -fsSLo ~/apache-jmeter/apache-jmeter-5.3.zip "https://downloads.apache.org//jmeter/binaries/apache-jmeter-5.3.zip"
  unzip ~/apache-jmeter/apache-jmeter-5.3.zip
  rm -f ~/apache-jmeter/apache-jmeter-5.3.zip
}

install_go() {
  curl -fsSLo go1.17.2.linux-amd64.tar.gz "https://golang.org/dl/go1.17.2.linux-amd64.tar.gz"
  sudo rm -rf /usr/local/go1.17.2.linux-amd64.tar.gz && sudo tar -C /usr/local -xzf go1.17.2.linux-amd64.tar.gz
  rm -f go1.17.2.linux-amd64.tar.gz
  go version
}

install_erlang_and_elixir() {
  asdf plugin add erlang https://github.com/asdf-vm/asdf-erlang.git
  asdf plugin add elixir https://github.com/asdf-vm/asdf-elixir.git
}

install_pyenv() {
  curl https://pyenv.run | bash
}

install_asdf() {
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.11.3
  echo '. $HOME/.asdf/asdf.sh' >> ~/.bashrc
  echo '. $HOME/.asdf/completions/asdf.bash' >> ~/.bashrc
}

echo 'Starting ubuntu install'

sudo apt-get upgrade && apt-get update

# Layer 1: Common tools
install_fzf
install_zellij > /dev/null 2>&1

# Layer 2: Arch independent software
install_brave
install_gnome_terminal_colors

# Layer 3: Cvinfra
install_aws
install_gcp
install_heroku
install_docker
install_docker_compose
install_k8s
install_go
install_erlang_and_elixir

# Layer 4: Leisure apps
install_spotify
install_atom
install_dbeaver

# Layer 5: Stack flavours
install_pyenv
install_asdf

remove_manual_ruby_install

setup_wallpaper
install_fira_code_font

install_jmeter

echo 'Minimal requests installed! =]'
