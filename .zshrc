#!/usr/local/bin/zsh

platform='unknown'
unamestr=$(uname)
if [[ "$unamestr" == 'Darwin' ]]; then
   platform='macos'
elif [[ "$unamestr" == 'Linux' ]]; then
   platform='linux'
fi

export ZSH=$HOME/.oh-my-zsh
export LANG=en_US.UTF-8
export DISABLE_AUTO_UPDATE="true"
export ZSH_THEME="robbyrussell"
export EDITOR='nvim'
export SHELL='zsh'
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export DISABLE_AUTO_TITLE=true
export ANSIBLE_HOST_KEY_CHECKING=False
export KEYTIMEOUT=1
export LISTMAX=9998

if [[ $platform == 'macos' ]]; then
    export VAGRANT_DEFAULT_PROVIDER='vmware_fusion'
    source ~/.homebrew.token

    export NEOVIM_LISTEN_ADDRESS=/tmp/neovim.sock
    export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-9.0.4.jdk/Contents/Home
    export GOPATH=/usr/local/lib/go

    export ANDROID_HOME=/usr/local/opt/android-sdk
    export GO_ROOT=$GOPATH/bin
    export BREW_ROOT=/usr/local/bin:/usr/local/sbin
    export CARGO_ROOT=~/.cargo/bin
    export OPENSSL_INCLUDE_DIR=/usr/local/opt/openssl/include
    export OPENSSL_LIB_DIR=/usr/local/opt/openssl/lib

    export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/Library/Frameworks/Mono.framework/Versions/Current/lib/pkgconfig

    export COFFEELINT_CONFIG=/Users/jacob/.coffeelintrc
    export DOTNET_PATH=/usr/local/share/dotnet
    export RUST_SRC_PATH=/usr/local/src/rust/src

    export PATH=/bin:/sbin:$BREW_ROOT:$GO_ROOT:$PATH:$DOTNET_PATH:$JAVA_HOME/bin:$CARGO_ROOT
fi

plugins=(vi-mode gitfast cake gem lein mvn node npm redis-cli github heroku mercurial vagrant coffee go bower scala rebar colorize cabal cpanm sbt mix tmux tmuxinator pod autojump docker docker-compose rsync extract encode64 history-substring-search copyfile zsh_reload jsontools grunt adb terraform ember-cli colored-man-pages rust react-native yarn cp pip cargo)

if [[ $platform == 'macos' ]]; then
    plugins+=(brew osx)
else
    plugins+=(debian command-not-found)
fi

autoload zargs
autoload zmv

zmodload zsh/datetime
zmodload zsh/stat
zmodload zsh/files
zmodload zsh/mapfile
zmodload zsh/mathfunc
zmodload zsh/net/socket
zmodload zsh/zftp
zmodload zsh/attr
zmodload zsh/net/tcp

unsetopt listambiguous

source "$ZSH/oh-my-zsh.sh"

if [[ $platform == 'macos' ]]; then
    alias vim='shell=bash nvim'
    alias vi='shell=bash nvim'
    alias 9="/usr/local/bin/9"
    alias galileo="screen /dev/tty.usbserial 115200"
fi

alias space="du -hs * | gsort -h"
alias fuck='eval $(thefuck $(fc -ln -1 | tail -n 1)); fc -R'
alias rg='rg -S'
alias l="ls"
alias xsp="MONO_OPTIONS=--arch=64 xsp4 --port 8080"
alias ssh-tunnel="ssh -D 8080 -C -N immersiveapplications.com"
alias sl="ls"
alias git-oops="git reset --soft HEAD~"
alias git-clear="git reset --hard HEAD"
alias flush-cache="sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder"
alias mux="tmuxinator"
alias redis-master="redis-cli -h qa-db -p 26379 SENTINEL get-master-addr-by-name eflex-redis"

# OPAM configuration
. /Users/jacob/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

function clean-eflex() {
    tmux kill-server
}

function restart-eflex() {
    clean-eflex
    mux eflex
}

function update-servers() {
    ansible all -i /usr/local/etc/ansible/hosts -m "apt" -a "upgrade=dist autoremove=true update_cache=true" -b
    ansible integration -i /usr/local/etc/ansible/hosts -m "shell" -a "docker pull selenium/standalone-chrome" -b
    ansible integration -i /usr/local/etc/ansible/hosts -m "shell" -a "docker stop selenium && docker rm selenium" -b
    ansible integration -i /usr/local/etc/ansible/hosts -m "shell" -a "docker run --name selenium --restart=always -v /dev/shm:/dev/shm -d --publish=4444:4444 selenium/standalone-chrome" -b
    ansible all -i /usr/local/etc/ansible/hosts -m "shell" -a "apt-get autoremove -y" -b
}

function update() {
    setopt localoptions rmstarsilent
    unsetopt nomatch

    echo "updating homebrew packages"
    brew update
    brew upgrade
    brew cleanup -s
    brew prune
    brew tap --repair
    rm -rf /Library/Caches/Homebrew/* 2>/dev/null
    rm -rf ~/Library/Caches/Homebrew/* 2>/dev/null

    echo "updating vim plugins"
    vim +PlugUpdate +PlugUpgrade +qa

    echo "updating node packages"
    yarn global upgrade --latest

    echo "updating ruby gems"
    gem update
    gem cleanup

    echo "updating julia packages"
    julia -e "Pkg.update()"

    echo "updating phoenix and mix"
    mix local.hex --force
    mix archive.install https://github.com/phoenixframework/archives/raw/master/phx_new.ez --force

    echo "update tex packages"
    tlmgr update --self --all --reinstall-forcibly-removed

    echo "upgrade cask packages"
    brew cu --all --cleanup -q -y
}

function fix-watchman() {
  watchman watch-del "/Users/jacob/dev/eflexsystems/eflex/webApp"
  lunchy restart watchman
}

eval "$(rbenv init -)"
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'
