sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y

# add ppas
sudo add-apt-repository -y ppa:webupd8team/java
sudo add-apt-repository -y ppa:webupd8team/sublime-text-2
sudo add-apt-repository -y ppa:juju/devel
sudo add-apt-repository -y ppa:chris-lea/node.js
sudo add-apt-repository -y ppa:rquillo/ansible

sudo apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10
sudo sh -c 'echo "deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen" > /etc/apt/sources.list.d/10gen.list'

sudo apt-get update

sudo apt-get install -y build-essential llvm clang \
  mono-gmcs python2.7 python3.3 ansible tortoisehg \
  perl ghc cabal-install golang-go golang-go libtool \
  golang-tools erlang gprolog quickly quickly-ubuntu-template \
  redis-server oracle-java7-installer nginx gnome-sharp2 \
  zookeeper zookeeperd zookeeper-bin sublime-text juju-core \
  nodejs mongodb-10gen rabbitmq-server tmux vim p7zip \
  cmake wget curl exuberant-ctags htop zsh subversion \
  mercurial git cvs unzip automake pv dtrx rsync libglade2.0-cil-dev \
  parallel ack cifs-utils smbclient winbind vsftpd \
  gawk ack-grep ufw libnss-mdns sshpass apt-offline \
  python-httplib2 linux-firmware-nonfree python-keyczar

# beyond compare
wget http://www.scootersoftware.com/bcompare-3.3.8.16340_amd64.deb
sudo dpkg -i bcompare-3.3.8.16340_amd64.deb
sudo apt-get -f -y install

# robomongo
wget http://robomongo.org/files/linux/robomongo-0.8.2-x86_64.deb
sudo dpkg -i robomongo-0.8.2-x86_64.deb
sudo apt-get -f -y install

# install rvm and ruby
curl -L https://get.rvm.io | bash -s stable --rails --autolibs=enabled

# npm packages
sudo npm install -g mocha cucumber coffee-script iced-coffee-script brunch bower mocha-phantomjs

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
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i ./google-chrome*.deb
sudo apt-get -f -y install

mkdir ~/apps

# intellij
wget http://download.jetbrains.com/idea/ideaIU-12.1.4.tar.gz
tar xfz ideaIU-12.1.4.tar.gz
mv idea-IU-129.713 ~/apps/idea

# rubymine
wget http://download.jetbrains.com/ruby/RubyMine-5.4.3.tar.gz -T 5
tar xfz RubyMine-5.4.3.tar.gz
mv RubyMine-5.4.3 ~/apps/rubymine

# juju keygen
ssh-keygen -t rsa -b 2048
juju generate-config -w
juju bootstrap

rm *.deb
rm *.gz

# mono
mkdir -p dev/src
cd dev/src
git clone https://github.com/mono/mono.git --depth 100
cd mono
git checkout 'mono-3.2.3'
git submodule update --init --recursive
./autogen.sh --prefix=/usr
make -j2
sudo make install
make clean

cd ~/dev/src
git clone https://github.com/mono/xsp.git --depth 100
cd xsp
./autogen.sh --prefix=/usr
make -j2
sudo make install
make clean

cd ~/dev/src
git clone https://github.com/mono/monodevelop.git
cd monodevelop
git submodule update --init --recursive
./configure --profile=dist
make -j2
sudo make install
make clean
