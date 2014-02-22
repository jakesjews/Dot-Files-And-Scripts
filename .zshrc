ZSH=$HOME/.oh-my-zsh

LANG=en_US.UTF-8

ZSH_THEME="robbyrussell"

alias space="du -d 1 -h | sort -n"
alias tracegl="node /usr/local/bin/tracegl.js"
alias l="ls"
alias immersiveapps='ssh immersiveapplications.com'
alias ed='ged -p:'
alias mmv="noglob zmv -W"
alias xsp="xsp4"
alias ssh-tunnel="ssh -D 8080 -C -N immersiveapplications.com"
alias ms='mocha -g "#slow" -i'
alias redis='redis-server /usr/local/etc/redis.conf'
alias zk='zkServer start-foreground'
alias julia='/Applications/Julia.app/Contents/Resources/julia/bin/julia'
alias vim='mvim -v'

plugins=(ant bundler vi-mode gitfast brew cake gem lein mvn node osx perl redis-cli textmate github heroku mercurial npm pip python sublime vagrant coffee git-extras pow svn golang bower scala rebar rails colorize zsh-syntax-highlighting cabal cpanm jira sbt mix tmux mosh rvm ruby rake dircycle pod autojump vundle colored-man docker rsync extract encode64 history-substring-search copydir copyfile colorize cabal-upgrade functional npmls) 

source $ZSH/oh-my-zsh.sh

export ENABLE_CORRECTION="true"
export EDITOR='subl -w'
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export VAGRANT_DEFAULT_PROVIDER='vmware_fusion'
export HOMEBREW_GITHUB_API_TOKEN='c2cb29a67cee76e48d933eae6b36b9c51e79609b'
export NNTPSERVER='news.tweaknews.eu'
export MUTT_EMAIL_ADDRESS="jakesjews@gmail.com"
export MUTT_REALNAME="Jacob Jewell"
export MUTT_SMTP_URL="smtp://jakesjews@smtp.gmail.com:587/"

export JAVA_HOME=`/usr/libexec/java_home -v 1.7`
export HIVE_HOME=/usr/local/Cellar/hive/0.10.0/libexec
export PLAN9=/usr/local/plan9
export GROOVY_HOME=/usr/local/Cellar/groovy/2.0.5/libexec
export PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH
export NODE_PATH=/usr/local/share/npm/lib/node_modules
export GOPATH=/usr/local/opt/go/libexec
export VOLDEMORT_HOME='/usr/local/Cellar/voldemort/0.90.1/libexec'
export LIQUIBASE_HOME="/usr/local/Cellar/liquibase/3.1.1/libexec"
export JBOSS_HOME=/usr/local/opt/wildfly-as/libexec

export ANDROID_SDK_ROOT=/usr/local/opt/android-sdk
export POSTGRES_ROOT=/Applications/Postgres.app/Contents/Versions/9.3/bin
export J_ROOT=/Applications/j64-801/bin
export CLOJURE_ROOT=/Users/jacob/.cljr/bin
export CABAL_ROOT=/Users/jacob/.cabal/bin
export LATEX_ROOT=/usr/local/texlive/2013/bin/x86_64-darwin
export CUDA_ROOT=/Developer/NVIDIA/CUDA-5.5/bin
export VMWARE_ROOT="/Applications/VMware Fusion.app/Contents/Library"
export HEROKU_ROOT=/usr/local/heroku/bin
export PHP_ROOT=$(brew --prefix josegonzalez/php/php55)/bin

export PATH=$J_ROOT:$CABAL_ROOT:/usr/local/bin:/usr/local/sbin:$PHP_ROOT:$POSTGRES_ROOT:$CLOJURE_ROOT:$LATEX_ROOT:$HEROKU_ROOT:$VMWARE_ROOT:$GOPATH/bin:$PATH:$PLAN9/bin:$CUDA_ROOT:$JBOSS_HOME/bin

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

bindkey -v

alias 9=/usr/local/plan9/bin/9

go_libs="-lm"
go_flags="-g -Wall -include /usr/local/include/allheads.h -O3"
alias go_c="clang -xc '-' $go_libs $go_flags"

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
