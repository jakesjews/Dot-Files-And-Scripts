#!/usr/local/bin/zsh

platform='unknown'
unamestr=$(uname)
if [[ "$unamestr" == 'Darwin' ]]; then
   platform='macos'
elif [[ "$unamestr" == 'Linux' ]]; then
   platform='linux'
fi

ZSH=$HOME/.oh-my-zsh

LANG=en_US.UTF-8

zstyle ':vcs_info:*' enable git hg

export ENABLE_CORRECTION="true"
export DISABLE_AUTO_UPDATE="true"
export ZSH_THEME="robbyrussell"
export EDITOR='nvim'
export SHELL='zsh'
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export NNTPSERVER='news.tweaknews.eu'
export MUTT_EMAIL_ADDRESS="jakesjews@gmail.com"
export MUTT_REALNAME="Jacob Jewell"
export MUTT_SMTP_URL="smtp://jakesjews@smtp.gmail.com:587/"
export DISABLE_AUTO_TITLE=true
export TERM=xterm-256color
export ANSIBLE_HOST_KEY_CHECKING=False

if [[ $platform == 'macos' ]]; then
    alias swift="/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/swift"
    alias jconsole="/Applications/j64-802/bin/jconsole"
    alias npm="npm --node-gyp=/usr/local/lib/node_modules/pangyp/bin/node-gyp.js"

    export VAGRANT_DEFAULT_PROVIDER='vmware_fusion'
    source ~/.homebrew.token

    export NEOVIM_LISTEN_ADDRESS=/tmp/neovim.sock
    #export NVIM_TUI_ENABLE_TRUE_COLOR=1
    export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
    export HIVE_HOME=/usr/local/Cellar/hive/0.10.0/libexec
    export GROOVY_HOME=/usr/local/Cellar/groovy/2.0.5/libexec
    export GOPATH=/usr/local/lib/go
    export VOLDEMORT_HOME='/usr/local/Cellar/voldemort/0.90.1/libexec'
    export LIQUIBASE_HOME="/usr/local/Cellar/liquibase/3.1.1/libexec"
    export JBOSS_HOME=/usr/local/opt/wildfly-as/libexec

    export ANDROID_HOME=/usr/local/opt/android-sdk
    export POSTGRES_ROOT=/Applications/Postgres.app/Contents/Versions/9.4/bin
    export CLOJURE_ROOT=/Users/jacob/.cljr/bin
    export CABAL_ROOT=/Users/jacob/.cabal/bin
    export TEX_ROOT=/usr/textbin
    export LATEX_ROOT=/usr/local/texlive/2014/bin/x86_64-darwin
    export CUDA_ROOT=/Developer/NVIDIA/CUDA-5.5/bin
    export VMWARE_ROOT="/Applications/VMware Fusion.app/Contents/Library"
    export HEROKU_ROOT=/usr/local/heroku/bin
    export NPM_ROOT=/usr/local/share/npm/bin
    export GO_ROOT=$GOPATH/bin
    export JBOSS_ROOT=$JBOSS_HOME/bin
    export RVM_ROOT=$HOME/.rvm/bin
    export EMSCRIPTEN_ROOT="/Users/jacob/dev/sdk/emscripten/emscripten/1.13.0"
    export HAXE_STD_PATH="/usr/local/lib/haxe/std"
    export BREW_ROOT=/usr/local/bin:/usr/local/sbin

    # python
    #export WORKON_HOME=$HOME/.virtualenvs
    #export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python2.7
    #export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'
    #export PIP_VIRTUALENV_BASE=$WORKON_HOME
    #export PIP_RESPECT_VIRTUALENV=true

    export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/Library/Frameworks/Mono.framework/Versions/Current/lib/pkgconfig

    export NODE_PATH=/usr/local/lib/node_modules
    export COFFEELINT_CONFIG=/Users/jacob/.coffelintrc
    export JAVA_MAN=/Library/Java/JavaVirtualMachines/jdk1.8.0_25.jdk/Contents/Home/man
    export ERLANG_MAN=/usr/local/opt/erlang/lib/erlang/man

    export MANPATH=$JAVA_MAN:$MANPATH:$ERLANG_MAN

    export PATH=/bin:/sbin:$CABAL_ROOT:$BREW_ROOT:$POSTGRES_ROOT:$CLOJURE_ROOT:$LATEX_ROOT:$HEROKU_ROOT:$VMWARE_ROOT:$GO_ROOT:$PATH:$NPM_ROOT:$TEX_ROOT:$CUDA_ROOT:$JBOSS_ROOT:$RVM_ROOT:$EMSCRIPTEN_ROOT:$JAVA_HOME/bin
else
    export PATH=$PATH
fi

plugins=(vi-mode git cake gem lein mvn node redis-cli github heroku mercurial npm pip sublime vagrant coffee golang bower scala rebar colorize zsh-syntax-highlighting cabal cpanm jira sbt mix tmux rvm pod autojump vundle colored-man docker rsync extract encode64 history-substring-search copyfile colorize zsh_reload jsontools grunt cabal-upgrade functional npmls)

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

KEYTIMEOUT=1

source "$ZSH/oh-my-zsh.sh"
bindkey '\e[A' history-substring-search-up
bindkey '\e[B' history-substring-search-down

if [[ $platform == 'macos' ]]; then
    alias space="du -d 1 -h | sort -n"
    alias ed='ed -p:'
    alias redis='redis-server /usr/local/etc/redis.conf --daemonize no'
    alias zk='zkServer start-foreground'
    alias julia='/Applications/Julia.app/Contents/Resources/julia/bin/julia'
    alias vim='shell=bash nvim'
    alias mongod='mongod --config /usr/local/etc/mongod.conf'
    alias 9="/usr/local/bin/9"
    alias influxdb="influxdb -config=/usr/local/etc/influxdb.conf"
    alias elasticsearch="elasticsearch --config=/usr/local/opt/elasticsearch/config/elasticsearch.yml"
    alias betty="/usr/local/betty/main.rb"
    alias profile-mono="LD_LIBRARY_PATH=/Library/Frameworks/Mono.framework/Versions/Current/lib MONO_OPTIONS=--profile=log:noalloc xsp"
    alias factor="/Applications/factor/factor"
fi

alias l="ls"
alias immersiveapps='ssh immersiveapplications.com'
alias mmv="noglob zmv -W"
alias xsp="xsp4"
alias ssh-tunnel="ssh -D 8080 -C -N immersiveapplications.com"
alias ms='mocha --fgrep "#slow" -i'
alias findproc="pgrep -ifL"
alias clearParts="mongo /Users/jacob/dev/mongo/clearParts.js"
alias sl="ls"

function mcd() { mkdir "$1" && cd "$1"; }

function enable-mono-tools() { 
    export DYLD_FALLBACK_LIBRARY_PATH=/lib:/usr/lib:/usr/local/lib:/Library/Frameworks/Mono.framework/Versions/Current/lib
}

function clean-eflex() {
    tmux kill-server
    sudo pkill proftpd
}

function restart-eflex() {
    clean-eflex
    mux eflex
}

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# OPAM configuration
. /Users/jacob/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true


source ~/.xsh

