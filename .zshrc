# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias space="du -d 1 -h | sort"
alias vim="/Applications/MacVim.app/Contents/MacOS/Vim"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(git brew bundler cake cap gem lein mvn node osx perl rails3 redis-cli ruby rvm textmate github heroku mercurial npm pip python rake sublime vagrant)

source $ZSH/oh-my-zsh.sh

export EDITOR='subl -w'
export JAVA_HOME="$(/usr/libexec/java_home)"

export PLAN9=/usr/local/plan9

# Customize to your needs...
export PATH=/Applications/Postgres.app/Contents/MacOS/bin:/usr/local/cuda/bin:/usr/local/bin:/usr/local/sbin:/usr/local/share/python:/usr/local/share/python3:/usr/local/share/pypy:/Users/jacob/.rvm/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/Applications/Server.app/Contents/ServerRoot/usr/bin:/Applications/Server.app/Contents/ServerRoot/usr/sbin:/usr/tex/bin:/Users/jacob/.cljr/bin:/usr/local/Cellar/depot_tools/:$PLAN9/bin

if [ -f `brew --prefix`/etc/autojump ]; then
      . `brew --prefix`/etc/autojump
fi
