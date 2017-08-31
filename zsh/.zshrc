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
    export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
    export GOPATH=/usr/local/lib/go

    export ANDROID_HOME=/usr/local/opt/android-sdk
    export CLOJURE_ROOT=/Users/jacob/.cljr/bin
    export CABAL_ROOT=/Users/jacob/.cabal/bin
    export TEX_ROOT=/usr/textbin
    export LATEX_ROOT=/usr/local/texlive/2014/bin/x86_64-darwin
    export HEROKU_ROOT=/usr/local/heroku/bin
    export NPM_ROOT=/usr/local/share/npm/bin
    export GO_ROOT=$GOPATH/bin
    export BREW_ROOT=/usr/local/bin:/usr/local/sbin
    export CARGO_ROOT=~/.cargo/bin
    export OPENSSL_INCLUDE_DIR=`brew --prefix openssl`/include
    export OPENSSL_LIB_DIR=`brew --prefix openssl`/lib

    export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/Library/Frameworks/Mono.framework/Versions/Current/lib/pkgconfig

    export NODE_PATH=/usr/local/lib/node_modules
    export COFFEELINT_CONFIG=/Users/jacob/.coffeelintrc
    export JAVA_MAN=/Library/Java/JavaVirtualMachines/jdk1.8.0_72.jdk/Contents/Home/man
    export ERLANG_MAN=/usr/local/opt/erlang/lib/erlang/man

    export MANPATH=$JAVA_MAN:$MANPATH:$ERLANG_MAN
    export DOTNET_PATH=/usr/local/share/dotnet
    export RUST_SRC_PATH=/usr/local/src/rust/src

    export PATH=/bin:/sbin:$CABAL_ROOT:$BREW_ROOT:$CLOJURE_ROOT:$LATEX_ROOT:$HEROKU_ROOT:$GO_ROOT:$PATH:$NPM_ROOT:$TEX_ROOT:$CUDA_ROOT:$JBOSS_ROOT:$EMSCRIPTEN_ROOT:$DOTNET_PATH:$JAVA_HOME/bin:$CARGO_ROOT
else
    export PATH=$PATH
fi

plugins=(vi-mode gitfast cake gem lein mvn node npm redis-cli github heroku mercurial pip vagrant coffee go bower scala rebar colorize cabal cpanm sbt mix tmux tmuxinator pod autojump docker docker-compose rsync extract encode64 history-substring-search copyfile zsh_reload jsontools grunt adb terraform ember-cli colored-man-pages rust react-native yarn cp)

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
    alias jconsole="/Applications/j64-802/bin/jconsole"
    alias postgres="postgres -D /usr/local/var/postgres"
    alias Factor="/Applications/factor/factor"
    alias galileo="screen /dev/tty.usbserial 115200"
fi

alias space="du -hs * | gsort -h"
alias fuck='eval $(thefuck $(fc -ln -1 | tail -n 1)); fc -R'
alias rg='rg -i'
alias l="ls"
alias xsp="MONO_OPTIONS=--arch=64 xsp4 --port 8080"
alias ssh-tunnel="ssh -D 8080 -C -N immersiveapplications.com"
alias ms='mocha --fgrep "#slow" -i'
alias sl="ls"
alias npmo="npm outdated"
alias npmog="npm outdated -g"
alias git-oops="git reset --soft HEAD~"
alias git-clear="git reset --hard HEAD"
alias flush-cache="sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder; say cache flushed"
alias mux="tmuxinator"
alias redis-master="redis-cli -h qa-db -p 26379 SENTINEL get-master-addr-by-name eflex-redis"

# OPAM configuration
. /Users/jacob/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

function mcd() { mkdir "$1" && cd "$1"; }

function clean-eflex() {
    tmux kill-server
    sudo pkill proftpd
}

function restart-eflex() {
    clean-eflex
    mux eflex
}

function update-servers() {
    ansible all -m "apt" -a "upgrade=dist autoremove=true update_cache=true" -s
    ansible all -m "shell" -a "apt-get autoremove -y" -s
}

function update-eflexwork() {
    ansible eflexwork -m "shell" -a "docker pull eflexsystems/eflex:stable" -s --ask-sudo-pass
    ansible eflexwork -m "shell" -a "docker stop eflex && docker rm eflex && eflex-start" -s --ask-sudo-pass
    ansible eflexwork -m "shell" -a "sudo docker exec eflex /bin/bash -c 'cd /home/eflex/eflex && make migrate'" -s --ask-sudo-pass
}

function git-rename() {
    old_branch=$(git rev-parse --abbrev-ref HEAD)
    git branch -m "$old_branch" "$1"
    git push origin ":$old_branch"
    git push --set-upstream origin "$1"
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

    echo "updating npm packages"
    npm update -g
     
    echo "updating ruby gems"
    gem update

    expect -c "
        set timeout -1
        spawn gem cleanup
        set done 0

        while {\$done == 0} {
            expect {
                \"Continue with Uninstall\\\\\\? \\\\\\[Yn\\\\\\]\" { send \"n\r\" }
                \"Clean Up Complete\" { set done 1 }
            }
        }
        wait
        close $spawn_id
    "

    echo "updating julia packages"
    julia -e "Pkg.update()"

    echo "updating meteor"
    meteor update

    echo "updating vagrant plugins"
    vagrant plugin update

    echo "updating phoenix and mix"
    mix local.hex --force
    mix archive.install https://github.com/phoenixframework/archives/raw/master/phx_new.ez --force

    echo "update tex packages"
    tlmgr update --self --all --reinstall-forcibly-removed

    echo "outdated cask packages"
    brew cask outdated
}

eval "$(rbenv init -)"
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'
