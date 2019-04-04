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
export REPORTER=spec

if [[ $platform == 'macos' ]]; then
    export VAGRANT_DEFAULT_PROVIDER='vmware_fusion'

    source ~/.homebrew.token
    export HOMEBREW_NO_INSTALL_CLEANUP=true

    export RUBY_CFLAGS="-Os -march=native"

    export NEOVIM_LISTEN_ADDRESS=/tmp/neovim.sock
    export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-12.jdk/Contents/Home
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
    export FACTOR_ROOT=/Applications/factor
    export DENO_ROOT=/Users/jacob/.deno/bin
    export TPM_ROOT=~/.tmux/plugins/tpm

    export PATH=/bin:/sbin:$BREW_ROOT:$GO_ROOT:$PATH:$DOTNET_PATH:$JAVA_HOME/bin:$CARGO_ROOT:$FACTOR_ROOT:$DENO_ROOT:$TPM_ROOT
fi

plugins=(vi-mode gitfast cake gem lein mvn node npm redis-cli heroku mercurial vagrant coffee go bower scala rebar colorize cabal cpanm sbt mix tmux tmuxinator pod autojump docker docker-compose rsync extract encode64 history-substring-search copyfile zsh_reload jsontools grunt adb terraform ember-cli colored-man-pages rust react-native yarn cp pip cargo)

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
    alias 9="/usr/local/bin/9"
    alias galileo="screen /dev/tty.usbserial 115200"

    source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'
    source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'

    bindkey '^[[A' history-substring-search-up
    bindkey '^[[B' history-substring-search-down
    bindkey -M vicmd 'k' history-substring-search-up
    bindkey -M vicmd 'j' history-substring-search-down
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
alias vim='shell=bash nvim'
alias vi='shell=bash nvim'

function clean-eflex() {
    tmux kill-server
}

function restart-eflex() {
    clean-eflex
    mux eflex
}

function countInstances() {
    rg $1 -c | sort -k 2 -t ":" -n
}

function update-servers() {
    ansible all -i /usr/local/etc/ansible/hosts -m "apt" -a "upgrade=dist update_cache=true" -b
    ansible all -i /usr/local/etc/ansible/hosts -m "apt" -a "autoremove=true" -b

    ansible integration -i /usr/local/etc/ansible/hosts -m "shell" -a "docker pull selenium/standalone-chrome" -b
    ansible integration -i /usr/local/etc/ansible/hosts -m "shell" -a "docker stop selenium && docker rm selenium" -b
    ansible integration -i /usr/local/etc/ansible/hosts -m "shell" -a "docker run --name selenium --net=host --restart=always -v /dev/shm:/dev/shm -d selenium/standalone-chrome" -b
}

function update() {
    setopt localoptions rmstarsilent
    unsetopt nomatch

    echo "updating homebrew packages"
    brew update
    brew upgrade
    brew cleanup -s
    brew tap --repair
    rm -rf "$(brew --cache)"

    echo "updating node packages"
    npm update -g

    echo "updating vim plugins"
    vim +PlugUpdate +PlugUpgrade +UpdateRemotePlugins +qa

    echo "updating ruby gems"
    gem update
    gem cleanup

    echo "updating phoenix and mix"
    mix local.hex --force
    mix local.rebar --force
    mix archive.install https://github.com/phoenixframework/archives/raw/master/phx_new.ez --force

    echo "update tex packages"
    tlmgr update --self --all --reinstall-forcibly-removed

    echo "update rust packages"
    cargo install-update -a
    rustup update

    echo "upgrade oh-my-zsh"
    upgrade_oh_my_zsh

    echo "upgrade cask packages"
    brew cu --all -q -y

    echo "update app store apps"
    mas upgrade

    npm outdated -g
}

eval "$(rbenv init -)"

. /Users/jacob/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

