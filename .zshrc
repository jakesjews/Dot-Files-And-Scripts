ZSH=$HOME/.oh-my-zsh

LANG=en_US.UTF-8

ZSH_THEME="robbyrussell"

alias space="du -d 1 -h | sort -n"
alias ipconfig=ifconfig

plugins=(git brew bundler cake cap gem lein mvn node osx perl redis-cli ruby rvm textmate github heroku mercurial npm pip python rake sublime vagrant cap coffee fabric git-extras pow screen svn golang bower scala rebar rails3 colorize go)

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
export GOROOT=/usr/local/Cellar/go/1.0.3
export GOPATH=$GOROOT/bin

export PATH=/Applications/j64-701/bin:/Applications/Postgres.app/Contents/MacOS/bin:/usr/local/cuda/bin:/usr/local/bin:/usr/local/sbin:/usr/local/share/python:/usr/local/share/python3:/usr/local/share/pypy:/Users/jacob/.rvm/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/Applications/Server.app/Contents/ServerRoot/usr/bin:/Applications/Server.app/Contents/ServerRoot/usr/sbin:/usr/tex/bin:/Users/jacob/.cljr/bin:$PLAN9/bin:/Users/jacob/.cabal/bin:/usr/local/share/npm/bin:/usr/local/depot_tools:$GOPATH:$PATH

if [ -f `brew --prefix`/etc/autojump ]; then
      . `brew --prefix`/etc/autojump
fi

# ZSH Higher Order Functions
. $HOME/.zsh/functional/load

alias say=/usr/bin/say
