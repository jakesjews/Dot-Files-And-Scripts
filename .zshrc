#!/opt/homebrew/bin/zsh

ulimit -n 64000 unlimited

platform='unknown'
unamestr=$(uname)
if [[ "$unamestr" == 'Darwin' ]]; then
  platform='macos'
elif [[ "$unamestr" == 'Linux' ]]; then
  platform='linux'
fi

export ZSH=$HOME/.oh-my-zsh
export DISABLE_AUTO_UPDATE=true
export HYPHEN_INSENSITIVE=true
export COMPLETION_WAITING_DOTS=true
export ZSH_THEME="dracula"
export EDITOR='nvim'
export DISABLE_AUTO_TITLE=true
export ANSIBLE_HOST_KEY_CHECKING=false
export KEYTIMEOUT=1
export LISTMAX=10000
export HISTSIZE=1000000000
export HISTFILESIZE=1000000000
export REPORTER=spec
export ZSH_DISABLE_COMPFIX=true
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
export SKIM_DEFAULT_COMMAND="fd --type f"
export FZF_DEFAULT_COMMAND='fd --type f'
export CLICOLOR=1
export MCFLY_KEY_SCHEME=vim
export MCFLY_FUZZY=2

if [[ $platform == 'macos' ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"

  BREW_OPT="$HOMEBREW_PREFIX/opt"
  POSTGRES_ROOT="$BREW_OPT/postgresql@15"

  export LDFLAGS="-L$POSTGRES_ROOT/lib"
  export CPPFLAGS="-I$POSTGRES_ROOT/include"
  export PKG_CONFIG_PATH="$POSTGRES_ROOT/lib/pkgconfig"

  export HOMEBREW_NO_AUTO_UPDATE=1
  export HOMEBREW_BOOTSNAP=1
  export HOMEBREW_UPDATE_REPORT_ALL_FORMULAE=1
  export HOMEBREW_BAT=1
  export HOMEBREW_NO_INSTALL_CLEANUP=1
  export HOMEBREW_NO_INSTALL_FROM_API=1
  export VAGRANT_DEFAULT_PROVIDER='vmware_desktop'
  export DOTNET_ROLL_FORWARD=Major
  export SSH_AUTH_SOCK="$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
  export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
  export PUPPETEER_EXPERIMENTAL_CHROMIUM_MAC_ARM=true

  export LOGTALKHOME=$BREW_OPT/logtalk/share/logtalk
  export GLASSFISH_HOME=$BREW_OPT/glassfish/libexec
  export CARGO_ROOT="$HOME/.cargo/bin"
  export ANDROID_SDK_ROOT="$HOMEBREW_PREFIX/share/android-sdk"
  export TPM_ROOT="$HOME/.tmux/plugins/tpm"
  export DART_ROOT="$HOME/.pub-cache/bin"
  export CABAL_DIR="$HOME/.cabal/bin"
  export QHOME="$HOME/.q"
  export PLAN9_HOME=/opt/plan9
  export NIM_ROOT="$HOME/.nimble/bin"
  export SML_ROOT=/usr/local/smlnj/bin
  export ESVU_ROOT="$HOME/.esvu/bin"
  export ARC_DIR="$HOME/.arc"
  export LLVM_ROOT="$BREW_OPT/llvm/bin"
  export LOCAL_BIN_ROOT="$HOME/.local/bin"
  export BINGO_ROOT="$HOME/.bingo/bin"
  export ESCRIPTS_ROOT="$HOME/.mix/escripts"
  export DENO_ROOT="$HOME/.deno/bin"
  export PORTER_ROOT="$HOME/.porter"
  DOTNET_TOOLS="$HOME/.dotnet/tools"
  JENV_ROOT="$HOME/.jenv/bin"
  CLOJURE_BIN_ROOT="$HOME/.clojure-bin"
  PERL_ROOT="$HOME/.perl5"

  typeset -U path

  export path=(
    $HOMEBREW_PREFIX/sbin
    $BREW_OPT/python@3.11/libexec/bin
    $POSTGRES_ROOT/bin
    $path
    $GO_ROOT
    $CARGO_ROOT
    $TPM_ROOT
    $DART_ROOT
    $PLAN9_HOME/bin
    $NIM_ROOT
    $SML_ROOT
    $ESVU_ROOT
    $CARP_DIR/bin
    $LOCAL_BIN_ROOT
    $LLVM_ROOT
    $CABAL_DIR
    $BINGO_ROOT
    $ESCRIPTS_ROOT
    $DENO_ROOT
    $HOME/.foundry/bin
    $DOTNET_TOOLS
    $JENV_PATH
    $CLOJURE_BIN_ROOT
    $HOME/.bin
  )

  export fpath=(
    "$HOMEBREW_PREFIX/share/zsh-completions"
    $fpath 
  )

  chmod -R go-w "$HOMEBREW_PREFIX/share/zsh"
  autoload -Uz compinit
  compinit -u
fi

plugins=(
  1password
  colored-man-pages
  copyfile
  cpanm
  dash
  dotnet
  encode64
  extract
  history-substring-search
  ipfs
  jira
  jsontools
  ng
  npm
  pip
  pod
  rbenv
  react-native
  rust
  terraform
  zoxide
)

autoload zargs
autoload zmv
autoload tcp_open

zmodload -F zsh/stat b:zstat
zmodload zsh/mapfile
zmodload zsh/mathfunc
zmodload zsh/net/socket
zmodload zsh/net/tcp
zmodload zsh/curses
zmodload zsh/pcre
zmodload zsh/zftp

unsetopt listambiguous
setopt inc_append_history

source "$ZSH/oh-my-zsh.sh"

if [[ $platform == 'macos' ]]; then
  alias stree="$HOMEBREW_PREFIX/bin/stree"
  alias arc="$HOME/.arc/arc.sh"
  alias q='rlwrap --remember $QHOME/m64/q'
  alias 9="$PLAN9_HOME/bin/9"
  alias jsc=/System/Library/Frameworks/JavaScriptCore.framework/Versions/Current/Helpers/jsc
  alias j=z
  alias factor=/Applications/factor/factor
  alias l=ls
  alias ssh-tunnel="ssh -D 8080 -C -N immersiveapplications.com"
  alias git-oops="git reset --soft HEAD~"
  alias flush-cache="sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder"
  alias redis-master="redis-cli -h qa-db -p 26379 SENTINEL get-master-addr-by-name eflex-redis"
  alias vim=nvim
  alias vi=nvim
  alias git-graph="git commit-graph write --reachable --changed-paths"
  alias mongo=mongosh
  alias bash="$HOMEBREW_PREFIX/bin/bash"
  alias make="$BREW_OPT/make/libexec/gnubin/make"
  alias rg-all="rg -uuuu"
  alias cpanm="cpanm --self-contained --local-lib='$PERL_ROOT' --local-lib-contained='$PERL_ROOT'"
  alias cargo-binstall='cargo-binstall --no-confirm'
  alias UVtoolsCmd=/Applications/UVtools.app/Contents/MacOS/UVtoolsCmd
fi

function mux() {
  tmuxinator start $1 --suppress-tmux-version-warning
}

function clean-eflex() {
  tmux kill-server
}

function zellij-eflex() {
  layout="eflex"
  if [[ $1 != "" ]]
  then
    layout="$1"
  fi
  session=$(zellij list-sessions)
  if [[ $session == *'eflex' ]]
  then
    zellij attach eflex
  else
    zellij --layout="$layout" --session=eflex
  fi
}

function zellij-eflex2() {
  eflex 'eflex2'
}

function zellij-clean-eflex() {
  zellij kill-session eflex
}

function clean-eflex-dir() {
  rm -rf "${TMPDIR}"v8-compile-cache*
  rm -rf "${TMPDIR}"broccoli-*
  rm -rf "${TMPDIR}"embroider
  rm -rf "${TMPDIR}"jacob/if-you-need-to-delete-this-open-an-issue-async-disk-cache
  rm -rf "${TMPDIR}"*Before*
  rm -rf "${TMPDIR}"*After*
  watchman watch-del-all
  cd "${HOME}"/dev/eflexsystems/eflex
  git remote prune origin
  git gc --force
  git lfs prune
  make clean
  cd "${HOME}"/dev/eflexsystems/eflex2
  git remote prune origin
  git gc --force
  git lfs prune
  make clean
}

function count-instances() {
  rg "$1" --count | sort --key=2 --field-separator=":" --numeric-sort
}

function flac-to-mp3() {
  for a in ./*.flac; do
    < /dev/null ffmpeg -i "$a" -qscale:a 0 "${a[@]/%flac/mp3}"
  done;
  rm ./*.flac
}

function update-servers() {
  ansible all --inventory /opt/homebrew/etc/ansible/hosts --forks 8 --module-name "apt" --args "upgrade=dist update_cache=true autoremove=true"
}

function pwdx {
  lsof -a -d cwd -p "$1" -n -Fn | awk '/^n/ {print substr($0,2)}'
}

function docker-clean {
  docker-sync-stack clean
  docker-compose down --volumes
  docker system prune --volumes --force
}

function rust-mode() {
  alias ascii=chars
  alias awk=frawk
  alias bc=eva
  alias cat=bat
  alias cd=z
  alias cksum=checkasum
  alias cloc=tokei
  alias col=xcol
  alias cp=fcp
  alias cut=tuc
  alias dd=bcp
  alias dig=doggo
  alias du=dua
  alias find=fd
  alias git=gix
  alias grep=rg
  alias hexdump=hexyl
  alias http-server=miniserve
  alias license=licensor
  alias locate=lolcate
  alias ls=exa
  alias markdown=comrak
  alias mutt=meli
  alias mv=pmv
  alias nano=amp
  alias objdump=bingrep
  alias pigz=crabz
  alias ping=gping
  alias ps=procs
  alias rm=rip
  alias sed=sd
  alias sleep=snore
  alias time=hyperfine
  alias tmux=zellij
  alias top=btm
  alias tree=broot
  alias uniq=huniq
  alias wait=stare
  alias watch=hwatch
  alias wc=cw
  alias xargs=rargs
  alias touch=bonk
}

function update() {
  setopt localoptions rmstarsilent
  unsetopt nomatch

  echo "updating homebrew packages"
  brew update
  brew upgrade

  echo "updating vim plugins"
  nvim --headless "+Lazy! update" +qa
  vim +TSUpdateSync +qa

  echo "updating ruby gems"
  gem update
  gem cleanup

  echo "updating phoenix and mix"
  mix local.hex --force
  mix local.rebar --force
  mix archive.install hex phx_new --force
  mix archive.install hex nerves_bootstrap --force
  mix escript.install hex livebook --force
  mix escript.install hex credo --force

  echo "update tex packages"
  tlmgr update --self --all --reinstall-forcibly-removed

  echo "update rust packages"
  rustup update
  cargo install-update --all
  cargo cache --autoclean

  echo "update pipx packages"
  pipx upgrade-all

  echo "upgrade dotnet tools"
  dotnet tool list -g | tail -n +3 | tr -s ' ' | cut -f 1 -d' ' | xargs -n 1 dotnet tool update -g

  echo "update go packages"
  for package in $(bingo installed -q)
  do
    bingo update "$package" --quiet
  done

  echo "update racket packages"
  raco pkg update --all -j 8 --batch --no-trash --deps search-auto

  echo "update perl packages"
  cpan-outdated -p --exclude-core -l "$PERL_ROOT" -L "$PERL_ROOT" | cpanm --force

  echo "update arduino"
  arduino-cli update
  arduino-cli upgrade

  echo "update zsh plugins"
  omz update --unattended
  git -C "$HOME/.oh-my-zsh/custom/themes/dracula" pull

  echo "ugrade tmux plugins"
  "$HOME/.tmux/plugins/tpm/bin/update_plugins" all

  echo "update ecmascript runtimes"
  esvu

  echo "update anarki"
  git -C "$HOME/.arc" pull

  echo "upgrade cask packages"
  brew cu --all --quiet --yes --no-brew-update

  echo "cleanup homebrew"
  brew autoremove
  brew cleanup -s
  brew tap --repair
  rm -rf "$(brew --cache)"

  echo "outdated python packages"
  pip3 list --user --outdated --not-required

  echo "outdated npm packages"
  npm outdated --location=global
}

function alphabetize_files() {
  unsetopt CASE_GLOB

  for i in {0..9} {a..z}
  do
    mkdir -p "${i}"
    mv -- "${i}"*(.) "${i}"/
  done
}

function quartus_compile() {
  docker run --platform linux/amd64 -it --rm -v $(pwd):/build jakesjews/quartus-mac-arm quartus_sh --flow compile "$1"
}

function restore_history() {
  sqlite3 "$HOME/Library/Application Support/McFly/history.db" 'select ": " || id || ":0;" || cmd from commands order by id;' > "$HOME/.zsh_history"
}

function brew_check_new_rust() {
  comm -23 <(brew uses rust --include-build --eval-all) <(brew uses rust --include-build --installed)
}

function node_list_requires() {
  rg \
    --only-matching \
    --replace '$1' \
    --engine=auto \
    --no-fixed-strings \
    --no-filename \
    --no-line-number \
    --no-heading \
    --regexp "require\('((?!\.)(?!node:)(?!@eflex\/lib).*)'\)" \
    "$1" | sort -u
}

function zvm_before_init() {
  zvm_bindkey viins '^[[A' history-substring-search-up
  zvm_bindkey viins '^[[B' history-substring-search-down
  zvm_bindkey vicmd '^[[A' history-substring-search-up
  zvm_bindkey vicmd '^[[B' history-substring-search-down
}

function zvm_after_init() {
  eval "$(mcfly init zsh)"

  function zvm_vi_yank() {
    zvm_yank
    echo ${CUTBUFFER} | pbcopy
    zvm_exit_visual_mode
  }
}

if [[ $platform == 'macos' ]]; then
  eval $(perl -I$PERL_ROOT/lib/perl5 -Mlocal::lib=$PERL_ROOT)
  source "$HOME/.opam/opam-init/init.zsh"
  source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  source $BREW_OPT/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
  source $BREW_OPT/zsh-fast-syntax-highlighting/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
  source "$HOME/.config/op/plugins.sh"
  eval "$(jenv init -)"
fi
