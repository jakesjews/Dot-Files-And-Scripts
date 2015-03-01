sudo apt-get update
sudo apt-get dist-upgrade -y

# add ppas
sudo add-apt-repository -y ppa:webupd8team/java
sudo add-apt-repository -y ppa:chris-lea/node.js
sudo add-apt-repository -y ppa:rquillo/ansible

sudo apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10
sudo sh -c 'echo "deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen" > /etc/apt/sources.list.d/10gen.list'

sudo sh -c "sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9"
sudo sh -c "echo deb http://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list"

sudo apt-get update

sudo apt-get install -y build-essential llvm clang \
  python2.7 ansible \
  perl ghc cabal-install golang-go libtool \
  erlang gprolog \
  redis-server oracle-java8-installer nginx \
  zookeeper zookeeperd zookeeper-bin \
  nodejs mongodb-org tmux vim p7zip \
  cmake wget curl exuberant-ctags htop zsh subversion \
  mercurial git cvs unzip automake pv dtrx rsync \
  parallel smbclient silversearcher-ag \
  gawk ufw libnss-mdns sshpass apt-offline \
  linux-firmware-nonfree python-keyczar fail2ban \
  libboost-all-dev scons lxc-docker mono-devel mono-xsp

# install rvm and ruby
curl -L https://get.rvm.io | bash -s stable --rails --autolibs=enabled

# npm packages
sudo npm install -g mocha coffee-script iced-coffee-script brunch bower mocha-phantomjs phantomjs

# clojure
wget https://raw.github.com/technomancy/leiningen/stable/bin/lein
sudo mv lein /usr/local/bin/
sudo chmod +x /usr/local/bin/lein

# vim
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
wget "https://raw.githubusercontent.com/jakesjews/Dot-Files-And-Scripts/master/vim/.vimrc" -P ~/

# oh-my-zsh
curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
wget "https://raw.githubusercontent.com/jakesjews/Dot-Files-And-Scripts/master/zsh/.zshrc" -P ~/
