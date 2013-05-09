sudo apt-get update

sudo apt-get install -y build-essential llvm clang \
  mono-runtime python2.7 python3.3 python-software-properties \
  perl ghc cabal-install golang-go golang-go \
  golang-tools erlang gprolog g++ make quickly quickly-ubuntu-template

sudo apt-get install -y tmux vim p7zip cmake curl wget exuberant-ctags htop zsh

sudo apt-get install -y postgresql

sudo apt-get install -y subversion mercurial git cvs

# java 7
sudo add-apt-repository -y ppa:webupd8team/java
sudo apt-get update
sudo apt-get install -y oracle-java7-installer

# nginx
sudo add-apt-repository -y ppa:nginx/stable
sudo apt-get update
sudo apt-get install -y nginx

# zookeeper
sudo add-apt-repository -y ppa:hadoop-ubuntu/stable
sudo apt-get update
sudo apt-get install hadoop-zookeeper-server

# rabbit-mq
sudo ` echo "deb http://www.rabbitmq.com/debian/ testing main" > /etc/apt/sources.list `
wget http://www.rabbitmq.com/rabbitmq-signing-key-public.asc
sudo apt-key add rabbitmq-signing-key-public.asc
rm rabbitmq-signing-key-public.asc
sudo apt-get install rabbitmq-server

# sublime text 2
sudo add-apt-repository -y ppa:webupd8team/sublime-text-2
sudo apt-get update
sudo apt-get install -y sublime-text

# beyond compare
wget http://www.scootersoftware.com/bcompare-3.3.7.15876_amd64.deb
sudo dpkg -i bcompare-3.3.7.15876_amd64.deb
sudo apt-get -f -y install

# mongodb
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10 -y
sudo sh -c 'echo "deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen" > /etc/apt/sources.list.d/10gen.list'
sudo apt-get update
sudo apt-get install -y mongodb-10gen

# install rvm and ruby
curl -L https://get.rvm.io | bash -s stable --rails --autolibs=enabled

# nodejs and coffee-script
sudo add-apt-repository -y ppa:chris-lea/node.js
sudo apt-get update
sudo apt-get install nodejs -y
sudo npm install -g mocha cucumber coffee-script iced-coffee-script

# clojure
wget https://raw.github.com/technomancy/leiningen/stable/bin/lein
sudo mv lein /usr/local/bin/
sudo chmod +x /usr/local/bin/lein

# vim
git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle/
wget "https://raw.github.com/jakesjews/Dot-Files-And-Scripts/master/.vimrc" -P ~/

# oh-my-zsh
curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
wget "https://raw.github.com/jakesjews/Dot-Files-And-Scripts/master/.zshrc" -P ~/

# install Chrome
wget -c www.mirrorservice.org/sites/archive.ubuntu.com/ubuntu//pool/main/u/udev/libudev0_175-0ubuntu13_amd64.deb
sudo dpkg -i libudev0*.deb
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i ./google-chrome*.deb
sudo apt-get -f -y install

mkdir ~/apps

# intellij
wget http://download.jetbrains.com/idea/ideaIU-12.1.2.tar.gz -T 5
tar xfz ideaIU-12.1.2.tar.gz
mv idea-IU-129.354 ~/apps/idea

# rubymine
wget http://download.jetbrains.com/ruby/RubyMine-5.4.1.tar.gz -T 5
tar xfz RubyMine-5.4.1.tar.gz
mv RubyMine-5.4.1 ~/apps/rubymine

# juju
sudo add-apt-repository -y ppa:juju/devel
sudo apt-get update
sudo apt-get install -y juju-core
ssh-keygen -t rsa -b 2048
juju generate-config -w
juju bootstrap

sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y

rm *.deb
rm *.gz
