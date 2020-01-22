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
export ZSH_THEME="dracula"
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
    export VAGRANT_DEFAULT_PROVIDER='vmware_desktop'

    source ~/.homebrew.token
    export HOMEBREW_NO_AUTO_UPDATE=1
    export HOMEBREW_NO_INSTALL_CLEANUP=1

    export RUBY_CFLAGS="-Os -march=native"

    export NEOVIM_LISTEN_ADDRESS=/tmp/neovim.sock
    export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-13.0.1.jdk/Contents/Home
    export GOPATH=/usr/local/lib/go

    export ANDROID_SDK_ROOT="/usr/local/share/android-sdk"
    export GO_ROOT=$GOPATH/bin
    export BREW_ROOT=/usr/local/bin:/usr/local/sbin
    export CARGO_ROOT=~/.cargo/bin
    export OPENSSL_INCLUDE_DIR=/usr/local/opt/openssl/include
    export OPENSSL_LIB_DIR=/usr/local/opt/openssl/lib

    export COFFEELINT_CONFIG=/Users/jacob/.coffeelintrc
    export FACTOR_ROOT=/Applications/factor
    export DENO_ROOT=/Users/jacob/.deno/bin
    export TPM_ROOT=~/.tmux/plugins/tpm
    export DART_ROOT=~/.pub-cache/bin
    export WASMER_DIR="$HOME/.wasmer"
    export CABAL_DIR="$HOME/.cabal/bin"
    export QHOME="$HOME/.q"
    export PLAN9=/usr/local/plan9

    export PATH=/usr/local/sbin:$GO_ROOT:$PATH:$JAVA_HOME/bin:$CARGO_ROOT:$FACTOR_ROOT:$DENO_ROOT:$TPM_ROOT:$DART_ROOT
fi

plugins=(vi-mode gitfast cake gem lein mvn node npm redis-cli heroku mercurial vagrant coffee go bower scala rebar colorize cabal cpanm sbt mix tmux tmuxinator pod autojump docker docker-compose rsync extract encode64 history-substring-search copyfile zsh_reload jsontools grunt adb terraform ember-cli colored-man-pages rust react-native yarn cp pip cargo kubectl httpie jira redis-cli ng fzf)

if [[ $platform == 'macos' ]]; then
    plugins+=(brew osx)
else
    plugins+=(debian command-not-found)
fi

autoload zargs
autoload zmv
autoload tcp_open

zmodload zsh/datetime
zmodload zsh/stat
zmodload zsh/files
zmodload zsh/mapfile
zmodload zsh/mathfunc
zmodload zsh/net/socket
zmodload zsh/net/tcp

unsetopt listambiguous

source "$ZSH/oh-my-zsh.sh"

if [[ $platform == 'macos' ]]; then
    alias q='rlwrap -r $QHOME/m64/q'
    alias 9="/usr/local/plan9/bin/9"

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
alias rg='rg -S --auto-hybrid-regex'
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

function flacToMp3() {
    for a in ./*.flac; do
      < /dev/null ffmpeg -i "$a" -qscale:a 0 "${a[@]/%flac/mp3}"
    done
    rm *.flac
}

function wavToMp3() {
    for a in ./*.wav; do
      < /dev/null ffmpeg -i "$a" "${a[@]/%wav/mp3}"
    done
}

function update-servers() {
    ansible all -i /usr/local/etc/ansible/hosts -f 12 -m "apt" -a "upgrade=dist update_cache=true" -b
    ansible all -i /usr/local/etc/ansible/hosts -f 12 -m "apt" -a "autoremove=true" -b

    ansible integration -i /usr/local/etc/ansible/hosts -f 3 -m "shell" -a "docker pull selenium/standalone-chrome" -b
    ansible integration -i /usr/local/etc/ansible/hosts -f 3 -m "shell" -a "docker stop selenium && docker rm selenium" -b
    ansible integration -i /usr/local/etc/ansible/hosts -f 3 -m "shell" -a "docker run --name selenium --net=host --restart=always -v /dev/shm:/dev/shm -d selenium/standalone-chrome" -b
}

function pwdx {
  lsof -a -d cwd -p $1 -n -Fn | awk '/^n/ {print substr($0,2)}'
}

function rustMode() {
    alias cat=bat
    alias ps=procs
    alias xargs=rargs
    alias ls=exa
    alias find=fd
    alias sed=sd
    alias uniq=runiq
    alias du=dust
    alias cp=xcp
    alias hexdump=hexyl
    alias ascii=chars
    alias tree=broot
    alias bc=eva
    alias rm=rip
    alias dd=bcp
    alias wc=cw
    alias less=peep
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
    mix archive.install hex phx_new --force

    echo "update tex packages"
    tlmgr update --self --all

    echo "update rust packages"
    rustup update
    cargo install-update -a
    cargo cache --autoclean

    echo "update wasmer"
    wasmer self-update

    echo "upgrade oh-my-zsh"
    upgrade_oh_my_zsh

    echo "upgrade cask packages"
    brew cu --all -q -y --no-brew-update
    rm -rf /usr/local/Caskroom/**/*.pkg

    echo "update app store apps"
    mas upgrade

    npm outdated -g
}

eval "$(rbenv init -)"

. /Users/jacob/.opam/opam-init/init.zsh > /dev/null 2> /dev/null

[ -s "$WASMER_DIR/wasmer.sh" ] && source "$WASMER_DIR/wasmer.sh"
