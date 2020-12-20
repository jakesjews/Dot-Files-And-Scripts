#!/usr/local/bin/zsh

platform='unknown'
unamestr=$(uname)
if [[ "$unamestr" == 'Darwin' ]]; then
    platform='macos'
elif [[ "$unamestr" == 'Linux' ]]; then
    platform='linux'
fi

if [[ -z $TMUX ]]; then
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
    export HISTSIZE=1000000000
    export HISTFILESIZE=1000000000
    export REPORTER=spec
    export ZSH_DISABLE_COMPFIX=true
    export ZSH_AUTOSUGGEST_USE_ASYNC=true
    export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
    export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
    export TEZOS_CLIENT_UNSAFE_DISABLE_DISCLAIMER=yes
    export SKIM_DEFAULT_COMMAND="fd --type f"
    export CLICOLOR=1
fi

if [[ -z $TMUX ]] && [[ $platform == 'macos' ]]; then
    export VAGRANT_DEFAULT_PROVIDER='vmware_desktop'

    source "$HOME/.homebrew.token"
    export HOMEBREW_NO_AUTO_UPDATE=1
    export HOMEBREW_NO_INSTALL_CLEANUP=1

    export NEOVIM_LISTEN_ADDRESS=/tmp/neovim.sock
    export JAVA_HOME=`/usr/libexec/java_home`
    export GOPATH=/usr/local/lib/go

    export ANDROID_SDK_ROOT="/usr/local/share/android-sdk"
    export GO_ROOT=$GOPATH/bin
    export BREW_ROOT=/usr/local/bin:/usr/local/sbin
    export CARGO_ROOT="$HOME/.cargo/bin"
    export OPENSSL_INCLUDE_DIR=/usr/local/opt/openssl/include
    export OPENSSL_LIB_DIR=/usr/local/opt/openssl/lib
    export RUBY_CFLAGS="-Os -march=native"
    export RUBY_CONFIGURE_OPTS="--with-openssl-dir=/usr/local/opt/openssl"
    export AIRFLOW_HOME="$HOME/.airflow"
    export LLVM_SYS_100_PREFIX=/usr/local/opt/llvm/
    export JIP_HOME="$HOME/.jip"

    export ADOBE_AIR_HOME="/usr/local/share/adobe-air-sdk"
    export NODE_PATH=/usr/local/lib/node_modules
    export FACTOR_ROOT=/Applications/factor
    export DENO_ROOT="$HOME/.deno/bin"
    export TPM_ROOT="$HOME/.tmux/plugins/tpm"
    export DART_ROOT="$HOME/.pub-cache/bin"
    export WASMER_DIR="$HOME/.wasmer"
    export CABAL_DIR="$HOME/.cabal/bin"
    export QHOME="$HOME/.q"
    export PLAN9=/usr/local/plan9
    export PYTHON_USER_PATH="$HOME/Library/Python/3.7/bin"
    export NIM_ROOT="$HOME/.nimble/bin"
    export DOTNET_TOOLS_ROOT="$HOME/.dotnet/tools"
    export COMPOSER_ROOT=$HOME/.composer/vendor/bin
    export SML_ROOT=/usr/local/smlnj/bin
    export WASMTIME_HOME="$HOME/.wasmtime"
    export ESVU_ROOT="$HOME/.esvu/bin"
    export SDKMAN_DIR="$HOME/.sdkman"
    export KHOME="/usr/local/bin"
    export CARP_DIR="$HOME/.carp"
    export ARC_DIR="$HOME/.arc"
    export CURL_HOME="/usr/local/opt/curl/bin"
    export EMACS_HOME="$HOME/.emacs.d/bin"

    export PATH=/usr/local/sbin:$CURL_HOME:$PATH:$GO_ROOT:$JAVA_HOME/bin:$CARGO_ROOT:$FACTOR_ROOT:$DENO_ROOT:$TPM_ROOT:$DART_ROOT:$PLAN9/bin:$PYTHON_USER_PATH:$NIM_ROOT:$DOTNET_TOOLS_ROOT:$COMPOSER_ROOT:$SML_ROOT:$WASMTIME_HOME/bin:$ESVU_ROOT:$SDKMAN_DIR/bin:$CARP_DIR/bin:$EMACS_HOME
fi

plugins=(vi-mode gitfast cake gem lein mvn node npm redis-cli heroku mercurial coffee golang bower scala rebar colorize cabal cpanm sbt mix tmux tmuxinator pod docker docker-compose rsync extract encode64 history-substring-search copyfile zsh_reload jsontools grunt adb terraform ember-cli colored-man-pages rust react-native yarn cp pip cargo httpie jira redis-cli ng sdk rbenv)

if [[ $platform == 'macos' ]]; then
    plugins+=(brew)
else
    plugins+=(debian command-not-found)
fi

autoload zargs
autoload zmv
autoload tcp_open

zmodload zsh/datetime
zmodload zsh/stat
zmodload zsh/mapfile
zmodload zsh/mathfunc
zmodload zsh/net/socket
zmodload zsh/net/tcp
zmodload zsh/curses
zmodload zsh/pcre
zmodload zsh/zftp
zmodload zsh/regex
zmodload zsh/system

unsetopt listambiguous
setopt inc_append_history

source "$ZSH/oh-my-zsh.sh"

if [[ $platform == 'macos' ]]; then
    alias q='rlwrap -r $QHOME/m64/q'
    alias 9="/usr/local/plan9/bin/9"
    alias sqlplus="DYLD_LIBRARY_PATH=/usr/local/lib /usr/local/bin/sqlplus"
    alias jsc="/System/Library/Frameworks/JavaScriptCore.framework/Versions/Current/Helpers/jsc"
    alias j=z

    source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

alias space="du -hs * | gsort -h"
alias rg='rg --smart-case --engine auto'
alias l="ls"
alias xsp="MONO_OPTIONS=--arch=64 xsp4 --port 8080"
alias ssh-tunnel="ssh -D 8080 -C -N immersiveapplications.com"
alias git-oops="git reset --soft HEAD~"
alias sl="ls"
alias flush-cache="sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder"
alias mux="tmuxinator"
alias redis-master="redis-cli -h qa-db -p 26379 SENTINEL get-master-addr-by-name eflex-redis"
alias vim='nvim'
alias vi='nvim'
alias x="$HOME/.dotnet/tools/x"
alias git-graph="git commit-graph write --reachable --changed-paths"

function clean-eflex() {
    tmux kill-server
}

function restart-eflex() {
    clean-eflex
    mux eflex
}

function count-instances() {
    rg $1 -c | sort -k 2 -t ":" -n
}

function flac-to-mp3() {
    for a in ./*.flac; do
      < /dev/null ffmpeg -i "$a" -qscale:a 0 "${a[@]/%flac/mp3}"
    done
    rm *.flac
}

function update-servers() {
    ansible all -i /usr/local/etc/ansible/hosts -f 9 -m "apt" -a "upgrade=dist update_cache=true" -b
    ansible all -i /usr/local/etc/ansible/hosts -f 9 -m "apt" -a "autoremove=true" -b

    ansible integration -i /usr/local/etc/ansible/hosts -f 3 -m "shell" -a "docker pull selenium/standalone-chrome" -b
    ansible integration -i /usr/local/etc/ansible/hosts -f 3 -m "shell" -a "docker stop selenium && docker rm selenium" -b
    ansible integration -i /usr/local/etc/ansible/hosts -f 3 -m "shell" -a "docker run --name selenium --net=host --restart=always -v /dev/shm:/dev/shm -d selenium/standalone-chrome" -b
}

function pwdx {
    lsof -a -d cwd -p $1 -n -Fn | awk '/^n/ {print substr($0,2)}'
}

function remove-trailing-whitespace {
    rename 's/ *$//' *
}

function docker-clean {
    docker-sync-stack clean
    docker-compose down --volumes
    docker system prune --volumes -f
}

function graal() {
    sdk use java 20.2.0.r11-grl
    export PATH=$HOME/.sdkman/candidates/java/20.2.0.r11-grl/bin:$PATH
}

function rust-mode() {
    alias cat=bat
    alias ps=procs
    alias xargs=rargs
    alias ls=exa
    alias find=fd
    alias sed=sd
    alias uniq=huniq
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
    alias nano=amp
    alias top=btm
    alias objdump=bingrep
    alias cksum=checkasum
    alias http-server=miniserve
    alias license=licensor
    alias cloc=tokei
    alias mutt=meli
    alias cut=choose
    alias cd=z
    alias awk=frawk
    alias cowsay=fsays
    alias markdown=comrak
    alias git=gix
    alias time=hyperfine
    alias locate=lolcate
    alias sleep=snore
    alias mv=pmv
    alias cksum=checkasum
    alias wait=stare
    alias dig=dog
    alias ping=gping
    alias curl=qurl
}

function liq() {
    clj -Sdeps '{:deps {mogenslund/liquid {:mvn/version "2.0.4"}}}' -m liq.core
}

function update-repos() {
    mr -j8 update
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
    mix archive.install hex nerves_bootstrap --force
 
    echo "update tex packages"
    tlmgr update --self --all --reinstall-forcibly-removed
 
    echo "update rust packages"
    rustup update
    cargo install-update -a
    cargo cache --autoclean
 
    echo "update quicklisp"
    sbcl --eval "(ql:update-client)" --quit
 
    echo "update pipx packages"
    pipx upgrade-all
 
    echo "upgrade dotnet tools"
    dotnet tool list -g | tail -n +3 | tr -s ' ' | cut -f 1 -d' ' | xargs -n 1 dotnet tool update -g

    echo "update composer packages"
    composer g update

    echo "update perl packages"
    cpan-outdated -p | cpanm

    echo "update app store apps"
    mas upgrade
 
    echo "update oh-my-zsh"
    omz update --unattended

    echo "ugrade tmux plugins"
    "$HOME/.tmux/plugins/tpm/bin/update_plugins" all

    echo "update ecmascript runtimes"
    esvu

    echo "update jdks"
    sdk selfupdate
    sdk update
    sdk upgrade

    echo "upgrade cask packages"
    brew cu --all -q -y --no-brew-update
 
    echo "outdated python packages"
    pip3 list --user --outdated --not-required
 
    echo "outdated npm packages"
    npm outdated -g
}

if [[ $platform == 'macos' ]]; then
    eval "$(zoxide init zsh)"
    source "$HOME/.opam/opam-init/init.zsh"
    source "$WASMER_DIR/wasmer.sh"
    eval $(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/.perl5)
    source "$HOME/.sdkman/bin/sdkman-init.sh"
fi
