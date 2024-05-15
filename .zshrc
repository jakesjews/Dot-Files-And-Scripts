#!/opt/homebrew/bin/zsh

ulimit -n 10240 unlimited

eval "$(/opt/homebrew/bin/brew shellenv)"

export ZSH_COMPDUMP="$HOME/.zcompdump-jacob"
export ZSH="$HOME/.oh-my-zsh"

local BREW_OPT="$HOMEBREW_PREFIX/opt"
local POSTGRES_ROOT="$BREW_OPT/postgresql@16"
local PLAN9_HOME=/opt/plan9

export PERL_ROOT="$HOME/.perl5"
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
export EMBER_PARALLEL=8
export ZSH_DISABLE_COMPFIX=true
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
export SKIM_DEFAULT_COMMAND="fd --type f"
export FZF_DEFAULT_COMMAND='fd --type f'
export CLICOLOR=1
export MCFLY_KEY_SCHEME=vim
export MCFLY_FUZZY=2
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_BOOTSNAP=1
export HOMEBREW_UPDATE_REPORT_ALL_FORMULAE=1
export HOMEBREW_BAT=1
export HOMEBREW_NO_INSTALL_CLEANUP=1
export HOMEBREW_NO_INSTALL_FROM_API=1
export PUPPETEER_EXPERIMENTAL_CHROMIUM_MAC_ARM=true
export DOTNET_ROLL_FORWARD=Major
export VAGRANT_DEFAULT_PROVIDER="parallels"
export SSH_AUTH_SOCK="$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
export GOPATH="$HOME/.go"
export QHOME="$HOME/.q"
export LOGTALKHOME="$BREW_OPT/logtalk/share/logtalk"
export GLASSFISH_HOME="$BREW_OPT/glassfish/libexec"
export ANDROID_SDK_ROOT="$HOMEBREW_PREFIX/share/android-sdk"
export CARP_DIR="$HOME/.carp"
export VOLTA_HOME="$HOME/.volta"

typeset -U path

export path=(
  "$BREW_OPT/python@3.12/libexec/bin"
  "$POSTGRES_ROOT/bin"
  $path
  "$HOME/.cargo/bin"
  "$HOME/.tmux/plugins/tpm"
  "$HOME/.pub-cache/bin" #dart
  "$PLAN9_HOME/bin"
  "$HOME/.nimble/bin"
  /usr/local/smlnj/bin
  "$HOME/.esvu/bin"
  "$CARP_DIR/bin"
  "$HOME/.local/bin" #pipx
  "$HOME/.cabal/bin"
  "$HOME/.go/bin"
  "$HOME/.mix/escripts"
  "$HOME/.deno/bin"
  "$HOME/.foundry/bin"
  "$HOME/.dotnet/tools"
  "$HOME/.jenv/bin"
  "$HOME/.clojure-bin"
  "$HOME/.datomic-bin/bin"
  "$HOME/.verible"
  "$HOME/.modular"
  "$HOME/.usr/bin"
)

export fpath=(
  "$HOMEBREW_PREFIX/share/zsh-completions"
  $fpath 
)

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
  pod
  react-native
  rust
  terraform
)

autoload zmv

unsetopt listambiguous
setopt inc_append_history

source "$ZSH/oh-my-zsh.sh"

alias stree="$HOMEBREW_PREFIX/bin/stree"
alias arc="$HOME/.arc/arc.sh"
alias q="rlwrap --remember $QHOME/m64/q"
alias 9="$PLAN9_HOME/bin/9"
alias factor=/Applications/factor/factor
alias l=ls
alias ssh-tunnel="ssh -D 8080 -C -N immersiveapplications.com"
alias git-oops="git reset --soft HEAD~"
alias flush-cache="sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder"
alias redis-master="redis-cli -h qa-db -p 26379 SENTINEL get-master-addr-by-name eflex-redis"
alias vim=nvim
alias vi=nvim
alias git-graph="git commit-graph write --reachable --changed-paths"
alias mongo="mongosh --quiet"
alias bash="$HOMEBREW_PREFIX/bin/bash"
alias make="$BREW_OPT/make/libexec/gnubin/make"
alias rg-all="rg -uuu"
alias cargo-binstall='cargo-binstall --no-confirm'
alias UVtoolsCmd=/Applications/UVtools.app/Contents/MacOS/UVtoolsCmd
alias jenv-start='eval "$(jenv init -)"'
alias ocamllsp="$HOME/.opam/default/bin/ocamllsp"
alias readme='glow README.md -p'
alias keka="/Applications/Keka.app/Contents/MacOS/Keka --cli"

function mux() {
  tmuxinator start "$1" --suppress-tmux-version-warning
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
  rm -rf /tmp/node-cache
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
  ansible \
    all \
    --inventory "$HOMEBREW_PREFIX/etc/ansible/hosts" \
    --forks 8 \
    --module-name "apt" \
    --args "upgrade=dist update_cache=true autoremove=true"
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
  alias parallel=rust-parallel
  alias pigz=crabz
  alias ping=gping
  alias ps=procs
  alias rm=rip
  alias sed=sd
  alias sleep=snore
  alias time=hyperfine
  alias tmux=zellij
  alias top=btm
  alias touch=bonk
  alias tree=broot
  alias uniq=huniq
  alias wait=stare
  alias watch=hwatch
  alias wc=cw
  alias whoami=whome
  alias xargs=rargs
}

function alphabetize_files() {
  unsetopt CASE_GLOB

  for i in {0..9} {a..z}
  do
    mkdir -p "${i}"
    mv -- "${i}"*(.) "${i}"/
  done
}

function quartus_mister() {
  docker run --platform linux/amd64 --rm -v "$(pwd):/build" -e DISPLAY=host.docker.internal:0 -v /tmp/.X11-unix:/tmp/.X11-unix jakesjews/quartus-mac-arm quartus
}

function quartus_mister_compile() {
  docker run --platform linux/amd64 -it --rm -v "$(pwd):/build" jakesjews/quartus-mac-arm quartus_sh --flow compile "$1"
}

function quartus_pocket() {
  docker run --platform linux/amd64 --rm -v "$(pwd):/build" -e DISPLAY=host.docker.internal:0 -v /tmp/.X11-unix:/tmp/.X11-unix didiermalenfant/quartus:22.1-apple-silicon quartus
}

function quartus_pocket_compile() {
  docker run --platform linux/amd64 -it --rm -v "$(pwd):/build" didiermalenfant/quartus:22.1-apple-silicon quartus_sh --flow compile "$1"
}

function reverse_bitstream() {
  perl -p -0777 -e '$_=~s/(.)/chr(((ord($1)*8623620610) & 1136090292240)%1023)/egs' "$1" > bitstream.rbf_r
}

function restore_history() {
  sqlite3 "$HOME/Library/Application Support/McFly/history.db" 'select ": " || id || ":0;" || cmd from commands order by id;' > "$HOME/.zsh_history"
}

function brew_check_new_rust() {
  comm -23 <(brew uses rust --include-build --eval-all) <(brew uses rust --include-build --installed)
}

function update() {
  setopt localoptions rmstarsilent
  unsetopt nomatch

  echo "updating homebrew packages"
  brew update
  brew upgrade --greedy-auto-updates

  echo "updating vim plugins"
  nvim --headless "+Lazy! sync" +qa
  nvim --headless "+TSUpdateSync" +qa
  nvim --headless "+MasonToolsUpdateSync" +qa

  echo "updating ruby gems"
  gem update --system
  gem update
  gem cleanup

  echo "updating elixir packages"
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
  dotnet tool list -g | tail -n +3 | tr -s ' ' | cut -f 1 -d' ' | xargs -n 1 dotnet tool update --global

  echo "update go packages"
  gup update

  echo "update racket packages"
  raco pkg update --all -j 8 --batch --no-trash --deps search-auto

  echo "update arduino"
  arduino-cli update
  arduino-cli upgrade

  echo "update gh-copilot"
  gh extension upgrade gh-copilot

  echo "update zsh plugins"
  omz update --unattended
  git -C "$HOME/.oh-my-zsh/custom/themes/dracula" pull

  echo "ugrade tmux plugins"
  "$HOME/.tmux/plugins/tpm/bin/update_plugins" all

  echo "update ecmascript runtimes"
  esvu --fast

  echo "update anarki"
  git -C "$HOME/.arc" pull

  echo "vscode extensions"
  code --update-extensions

  echo "upgrade cask packages"
  brew cu --all --yes --quiet --no-brew-update

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

function zvm_config() {
  ZVM_VI_SURROUND_BINDKEY=s-prefix
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

function conda-init() {
  eval "$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
}

function opam-init() {
  source "$HOME/.opam/opam-init/init.zsh"
}

function perl-init() {
  alias cpanm="cpanm --self-contained --local-lib='$PERL_ROOT' --local-lib-contained='$PERL_ROOT'"
  eval $(perl -I$PERL_ROOT/lib/perl5 -Mlocal::lib=$PERL_ROOT)
}

eval "$(rbenv init --no-rehash - zsh)"
source "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$BREW_OPT/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh"
source "$BREW_OPT/zsh-fast-syntax-highlighting/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"
source "$HOME/.config/op/plugins.sh"
eval "$(zoxide init --cmd j zsh)"
eval "$(gh copilot alias -- zsh)"

# https://github.com/zdharma-continuum/fast-syntax-highlighting/issues/27
FAST_HIGHLIGHT[chroma-man]=

autoload -U compinit
if [[ ! -f "$ZSH_COMPDUMP" || ! "$(find "$ZSH_COMPDUMP" -mtime 0)" ]]; then
  compinit -d "$ZSH_COMPDUMP"
else
  compinit -d "$ZSH_COMPDUMP" -C
fi


