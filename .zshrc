ZSH=$HOME/.oh-my-zsh

LANG=en_US.UTF-8

ZSH_THEME="robbyrussell"

alias space="du -d 1 -h | sort -n"
alias ipconfig=ifconfig
alias tracegl="node /usr/local/bin/tracegl.js"
alias l="ls"
alias immersiveapps='ssh immersiveapplications.com'
alias df='df -h'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias bc='bc -l'
alias diff='colordiff'

plugins=(git brew bundler cake gem lein mvn node osx perl redis-cli ruby rvm textmate github heroku mercurial npm pip python rake sublime vagrant coffee git-extras pow svn golang bower scala rebar rails3 colorize go web-search zsh-syntax-highlighting cabal vi-mode cpanm jira sbt)

source $ZSH/oh-my-zsh.sh

export EDITOR='subl -w'
export JAVA_HOME=`/usr/libexec/java_home -v 1.7`
export HIVE_HOME=/usr/local/Cellar/hive/0.10.0/libexec
export PLAN9=/usr/local/plan9
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export GROOVY_HOME=/usr/local/Cellar/groovy/2.0.5/libexec
export PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH
export NODE_PATH=/usr/local/share/npm/lib/node_modules
export GOROOT=/usr/local/Cellar/go/1.1
export GOPATH=/usr/local/share/go
export VAGRANT_DEFAULT_PROVIDER='vmware_fusion'
export HOMEBREW_GITHUB_API_TOKEN='c2cb29a67cee76e48d933eae6b36b9c51e79609b'
export TRELLO_DEVELOPER_PUBLIC_KEY='71a6e74bca14a27bed68987d533f8402'
export TRELLO_MEMBER_TOKEN='2b9bc77897f731d6400b3a3ead90d0eb60670855120dc148f93819f08851aadc'
export HOMEBREW_MAKE_JOBS=6
export VOLDEMORT_HOME='/usr/local/Cellar/voldemort/0.90.1/libexec'

export ANDROID_SDK_ROOT=/usr/local/opt/android-sdk
export POSTGRES_ROOT=/Applications/Postgres.app/Contents/MacOS/bin
export J_ROOT=/Applications/j64-701/bin
export SERVER_ROOT=/Applications/Server.app/Contents/ServerRoot/usr
export CLOJURE_ROOT=/Users/jacob/.cljr/bin
export CABAL_ROOT=/Users/jacob/.cabal/bin
export NPM_ROOT=/usr/local/share/npm/bin
export DEPOT_TOOLS_ROOT=/usr/local/depot_tools
export PYTHON_ROOT=/usr/local/share/python
export PYTHON3_ROOT=/usr/local/share/python3
export PYPY_ROOT=/usr/local/share/pypy
export RACKET_ROOT=/Applications/racket.5/bin
export LATEX_ROOT=/usr/local/texlive/2013/bin/x86_64-darwin
export CUDA_ROOT=/Developer/NVIDIA/CUDA-5.0/bin
export VMWARE_ROOT="/Applications/VMware Fusion.app/Contents/Library"

export PATH=$J_ROOT:/usr/local/bin:/usr/local/sbin:$POSTGRES_ROOT:/usr/bin:/usr/sbin:/bin:/sbin:$PYTHON_ROOT:$PYTHON3_ROOT:$PYPY_ROOT:$SERVER_ROOT/bin:$SERVER_ROOT/sbin:$CLOJURE_ROOT:$PLAN9/bin:$CABAL_ROOT:$NPM_ROOT:$DEPOT_TOOLS_ROOT:$GOPATH/bin:$RACKET_ROOT:$LATEX_ROOT:$CUDA_ROOT:$VMWARE_ROOT:$PATH

PATH=$PATH:$HOME/.rvm/bin

if [ -f `brew --prefix`/etc/autojump ]; then
      . `brew --prefix`/etc/autojump
fi

alias say=/usr/bin/say

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

# ZSH Higher Order Functions
. $HOME/.zsh/functional/load

#bindkey -v

alias 9=/usr/local/plan9/bin/9
