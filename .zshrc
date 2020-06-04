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
export ZSH_DISABLE_COMPFIX=true
export ZSH_AUTOSUGGEST_USE_ASYNC=true
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)

if [[ $platform == 'macos' ]]; then
    export VAGRANT_DEFAULT_PROVIDER='vmware_desktop'

    source ~/.homebrew.token
    export HOMEBREW_NO_AUTO_UPDATE=1
    export HOMEBREW_NO_INSTALL_CLEANUP=1

    export RUBY_CFLAGS="-Os -march=native"

    export NEOVIM_LISTEN_ADDRESS=/tmp/neovim.sock
    export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-14.0.1.jdk/Contents/Home
    export GOPATH=/usr/local/lib/go

    export ANDROID_SDK_ROOT="/usr/local/share/android-sdk"
    export GO_ROOT=$GOPATH/bin
    export BREW_ROOT=/usr/local/bin:/usr/local/sbin
    export CARGO_ROOT=~/.cargo/bin
    export OPENSSL_INCLUDE_DIR=/usr/local/opt/openssl/include
    export OPENSSL_LIB_DIR=/usr/local/opt/openssl/lib
    export RUBY_CONFIGURE_OPTS="--with-openssl-dir=/usr/local/opt/openssl@1.1"
    export AIRFLOW_HOME=~/.airflow

    export COFFEELINT_CONFIG=/Users/jacob/.coffeelintrc
    export FACTOR_ROOT=/Applications/factor
    export DENO_ROOT=/Users/jacob/.deno/bin
    export TPM_ROOT=~/.tmux/plugins/tpm
    export DART_ROOT=~/.pub-cache/bin
    export WASMER_DIR="$HOME/.wasmer"
    export CABAL_DIR="$HOME/.cabal/bin"
    export QHOME="$HOME/.q"
    export PLAN9=/usr/local/plan9
    export PYTHON_USER_PATH=/Users/jacob/Library/Python/3.7/bin
    export NIM_ROOT=~/.nimble/bin
    export DOTNET_TOOLS_ROOT=/Users/jacob/.dotnet/tools
    export COMPOSER_ROOT=/Users/jacob/.composer/vendor/bin

    export PATH=/usr/local/sbin:$PATH:$GO_ROOT:$JAVA_HOME/bin:$CARGO_ROOT:$FACTOR_ROOT:$DENO_ROOT:$TPM_ROOT:$DART_ROOT:$PLAN9/bin:$PYTHON_USER_PATH:$NIM_ROOT:$DOTNET_TOOLS_ROOT:$COMPOSER_ROOT
fi

plugins=(vi-mode gitfast cake gem lein mvn node npm redis-cli heroku mercurial vagrant coffee golang bower scala rebar colorize cabal cpanm sbt mix tmux tmuxinator pod docker docker-compose rsync extract encode64 history-substring-search copyfile zsh_reload jsontools grunt adb terraform ember-cli colored-man-pages rust react-native yarn cp pip cargo httpie jira redis-cli ng rbenv)

if [[ $platform == 'macos' ]]; then
    plugins+=(brew osx)
else
    plugins+=(debian command-not-found)
fi

autoload zargs
autoload zmv
autoload tcp_open
autoload calendar

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

source "$ZSH/oh-my-zsh.sh"

if [[ $platform == 'macos' ]]; then
    alias q='rlwrap -r $QHOME/m64/q'
    alias 9="/usr/local/plan9/bin/9"
    alias autojump=$CARGO_ROOT/autojump
    alias sqlplus="DYLD_LIBRARY_PATH=/usr/local/lib /usr/local/bin/sqlplus"

    source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'
    source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'

    bindkey '^[[A' history-substring-search-up
    bindkey '^[[B' history-substring-search-down
    bindkey -M vicmd 'k' history-substring-search-up
    bindkey -M vicmd 'j' history-substring-search-down
fi

alias space="du -hs * | gsort -h"
alias rg='rg -S --engine auto'
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
    ansible all -i /usr/local/etc/ansible/hosts -f 10 -m "apt" -a "upgrade=dist update_cache=true" -b
    ansible all -i /usr/local/etc/ansible/hosts -f 10 -m "apt" -a "autoremove=true" -b

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
   alias nano=kibi
   alias top=ytop
   alias objdump=bingrep
   alias http-server=miniserve
   alias license=licensor
   alias cloc=tokei
   alias mutt=meli
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

   echo "update quicklisp"
   sbcl --eval "(ql:update-client)" --quit

   echo "update pipx packages"
   pipx upgrade-all

   echo "upgrade oh-my-zsh"
   upgrade_oh_my_zsh

   echo "upgrade dotnet tools"
   dotnet tool list -g | tail -n +3 | tr -s ' ' | cut -f 1 -d' ' | xargs -n 1 dotnet tool update -g

   echo "update app store apps"
   mas upgrade

   echo "update gcloud"
   gcloud components update --quiet

   echo "upgrade cask packages"
   brew cu --all -q -y --no-brew-update
   rm -rf /usr/local/Caskroom/**/*.pkg

   echo "outdated python packages"
   pip3 list --user --outdated --not-required

   npm outdated -g
}

if [[ $platform == 'macos' ]]; then
    source /usr/local/etc/profile.d/autojump.sh
fi

[ -s $HOME/.opan ] && source $HOME/.opam/opam-init/init.zsh > /dev/null 2> /dev/null

[ -s "$WASMER_DIR/wasmer.sh" ] && source "$WASMER_DIR/wasmer.sh"

