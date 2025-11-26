#!/opt/homebrew/bin/zsh

ulimit -n 10240 unlimited

eval "$(/opt/homebrew/bin/brew shellenv)"

export ZSH_COMPDUMP="$HOME/.zcompdump-jacob"
export ZSH="$HOME/.oh-my-zsh"

export PLAN9=/opt/plan9
export PERL_ROOT="$HOME/.perl5"
export DISABLE_AUTO_UPDATE=true
export HYPHEN_INSENSITIVE=true
export COMPLETION_WAITING_DOTS=true
export ZSH_THEME="dracula"
export EDITOR='nvim'
export DISABLE_AUTO_TITLE=true
export ANSIBLE_HOST_KEY_CHECKING=false
export LISTMAX=10000
export HISTSIZE=1000000000
export SAVEHIST=1000000000
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
export HOMEBREW_UPDATE_REPORT_ALL_FORMULAE=1
export HOMEBREW_BAT=1
export HOMEBREW_NO_INSTALL_CLEANUP=1
export HOMEBREW_NO_INSTALL_FROM_API=1
export HOMEBREW_PRY=1
export HOMEBREW_UPGRADE_GREEDY=1
export DOTNET_ROLL_FORWARD=Major
export VAGRANT_DEFAULT_PROVIDER="parallels"
export SSH_AUTH_SOCK="$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
export GOPATH="$HOME/.go"
export QHOME="$HOME/.q"
export LOGTALKHOME="$HOMEBREW_PREFIX/opt/logtalk/share/logtalk"
export GLASSFISH_HOME="$HOMEBREW_PREFIX/opt/glassfish/libexec"
export ANDROID_SDK_ROOT="$HOMEBREW_PREFIX/share/android-sdk"
export CARP_DIR="$HOME/.carp"
export VOLTA_HOME="$HOME/.volta"
export AIDER_DARK_MODE=true
export PGRX_HOME="$HOME/.pgrx"
export POSTGRES_VERSION=18

typeset -U path

export path=(
  "$HOMEBREW_PREFIX/opt/python@3.14/libexec/bin"
  "$HOMEBREW_PREFIX/opt/postgresql@$POSTGRES_VERSION/bin"
  $path
  "$HOME/.cargo/bin"
  "$HOME/.tmux/plugins/tpm"
  "$HOME/.pub-cache/bin" #dart
  "$PLAN9/bin"
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
  "$HOME/.jenv/bin"
  "$HOME/.clojure-bin"
  "$HOME/.datomic-bin/bin"
  "$HOME/.verible"
  "$HOME/.usr/bin"
  "$HOME/.simh-tools"
  "$HOME/.dotnet/tools"
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
  kitty
  ng
  npm
  pnpm-shell-completion
  pod
  react-native
  rust
  terraform
)

autoload zmv

setopt listambiguous
setopt extendedglob numericglobsort no_nomatch
setopt inc_append_history

source "$ZSH/oh-my-zsh.sh"

setopt hist_ignore_all_dups hist_reduce_blanks hist_verify
setopt auto_pushd pushd_silent pushd_ignore_dups
setopt no_clobber no_beep    

alias stree="$HOMEBREW_PREFIX/bin/stree"
alias arc="$HOME/.arc/arc.sh"
alias q="rlwrap --remember $QHOME/m64/q"
alias 9="$PLAN9/bin/9"
alias factor=/Applications/factor/factor
alias l=ls
alias ssh-tunnel="ssh -D 8080 -C -N immersiveapplications.com"
alias vps="ssh root@192.81.212.121"
alias git-oops="git reset --soft HEAD~"
alias flush-cache="sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder"
alias vim=nvim
alias vi=nvim
alias git-graph="git commit-graph write --reachable --changed-paths"
alias mongo="mongosh --quiet"
alias bash="$HOMEBREW_PREFIX/bin/bash"
alias make="$HOMEBREW_PREFIX/opt/make/libexec/gnubin/make"
alias rg-all="rg -uuu"
alias cargo-binstall='cargo-binstall --no-confirm'
alias UVtoolsCmd=/Applications/UVtools.app/Contents/MacOS/UVtoolsCmd
alias jenv-start='eval "$(jenv init -)"'
alias readme='glow README.md -p'
alias smithery="npx @smithery/cli"
alias mux=tmuxinator

function count-instances() {
  rg "$1" --count | sort --key=2 --field-separator=":" --numeric-sort
}

function flac-to-mp3() {
  for a in ./*.flac; do
    < /dev/null ffmpeg -i "$a" -qscale:a 0 "${a%.flac}.mp3"
  done;
  rm ./*.flac
}

function pwdx {
  lsof -a -d cwd -p "$1" -n -Fn | awk '/^n/ {print substr($0,2)}'
}

function docker-clean {
  docker-sync-stack clean
  docker compose down --volumes
  docker system prune --volumes --force
}

function alphabetize_files() {
  emulate -L zsh
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

function update() {
  () {
    function print_section() {
      local total_length=${COLUMNS:-80}
      local dash_count=$(( (total_length - ${#1} - 2) / 2 ))
      local dashes=$(printf -- '-%.0s' {1..$dash_count})
      local bold_start="\e[1m"
      local bold_end="\e[0m"

      print -- "${bold_start}${dashes} ${1} ${dashes}${bold_end}"
    }

    setopt localoptions rmstarsilent

    print_section "updating homebrew packages"
    brew update
    brew upgrade --greedy-auto-updates

    print_section "updating vim plugins"
    nvim --headless "+Lazy! sync" +qa
    nvim --headless "+lua require('nvim-treesitter').install('all', { summary = true }):wait(300000)" +qa
    nvim --headless "+lua require('nvim-treesitter').update('all', { summary = true }):wait(300000)" +qa
    nvim --headless "+MasonToolsUpdateSync" +qa

    print_section "updating ruby gems"
    gem update --system
    gem update
    gem cleanup

    print_section "updating elixir packages"
    rebar3 update
    mix local.hex --force
    mix archive.install hex phx_new --force
    mix archive.install hex nerves_bootstrap --force
    mix escript.install hex livebook --force

    print_section "update tex packages"
    tlmgr update --self --all --reinstall-forcibly-removed

    print_section "update rust packages"
    rustup update
    cargo install-update --all
    cargo cache --autoclean

    print_section "update uv packages"
    uv tool upgrade --all

    print_section "upgrade dotnet tools"
    dotnet tool update --global --all

    print_section "update go packages"
    gup update

    print_section "update racket packages"
    raco pkg update --all --jobs 8 --batch --no-trash --deps search-auto

    print_section "update nim packages"
    nimble refresh --accept
    nimble list --installed --silent | while read -r line; do
      nim_pkg_name="${line%% *}"
      if [[ -n "$nim_pkg_name" ]]; then
        nimble install --accept "$nim_pkg_name"
      fi
    done

    print_section "update arduino"
    arduino-cli update
    arduino-cli upgrade --run-post-install --run-pre-uninstall
    arduino-cli cache clean

    print_section "update vagrant plugins"
    VAGRANT_DISABLE_STRICT_DEPENDENCY_ENFORCEMENT=1 vagrant plugin update

    print_section "update gh-copilot"
    gh extension upgrade gh-copilot

    print_section "update zsh plugins"
    "$ZSH/tools/upgrade.sh"
    git -C "$HOME/.oh-my-zsh/custom/themes/dracula" pull

    print_section "ugrade tmux plugins"
    "$HOME/.tmux/plugins/tpm/bin/update_plugins" all

    print_section "update ecmascript runtimes"
    esvu --fast

    print_section "update anarki"
    git -C "$HOME/.arc" pull

    print_section "update neovim lua references"
    git -C "$HOME/.config/nvim/src/luv" pull

    print_section "vscode extensions"
    code --update-extensions

    print_section 'google cloud cli'
    gcloud components update

    print_section "upgrade cask packages"
    brew cu --all --yes --quiet --no-brew-update

    print_section "cleanup homebrew"
    brew autoremove
    brew cleanup -s
    brew tap --repair
    rm -rf "$(brew --cache)"

    print_section "outdated python packages"
    pip3 list --user --outdated --not-required

    print_section "outdated npm packages"
    npm outdated --location=global
  }
}

function zvm_config() {
  ZVM_VI_SURROUND_BINDKEY=s-prefix
  ZVM_READKEY_ENGINE=$ZVM_READKEY_ENGINE_NEX
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

function radioconda-init() {
  conda-init
  conda activate radioconda
}

function gnuradio-cmake() {
  cmake -G Ninja -DCMAKE_INSTALL_PREFIX=$CONDA_PREFIX -DCMAKE_PREFIX_PATH=$CONDA_PREFIX -DLIB_SUFFIX="" ../
}

function gnuradio-compile() {
  cmake --build . --target install
}

function opam-init() {
  eval $(opam env)
}

function perl-init() {
  alias cpanm="cpanm --self-contained --local-lib='$PERL_ROOT' --local-lib-contained='$PERL_ROOT'"
  eval $(perl -I$PERL_ROOT/lib/perl5 -Mlocal::lib=$PERL_ROOT)
}

function update-pg-modeler() {
  qmake \
    -r pgmodeler.pro \
    -early \
      QMAKE_DEFAULT_LIBDIRS=$(xcrun -show-sdk-path)/usr/lib \
      PGSQL_INC=/opt/homebrew/include/postgresql@$POSTGRES_VERSION \
      PGSQL_LIB=/opt/homebrew/lib/postgresql@$POSTGRES_VERSION/libpq.dylib

  make -j8
  make install
}

function update-repos() {
  git for-each-repo --keep-going --config=maintenance.repo remote prune origin
  git for-each-repo --keep-going --config=maintenance.repo pull
  git for-each-repo --keep-going --config=maintenance.repo gc --aggressive --prune=now --force
}

eval "$(rbenv init --no-rehash - zsh)"
source "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$HOMEBREW_PREFIX/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh"
source "$HOMEBREW_PREFIX/opt/zsh-fast-syntax-highlighting/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"
source "$HOME/.config/op/plugins.sh"
eval "$(zoxide init --cmd j zsh)"
eval "$(gh copilot alias -- zsh)"

# https://github.com/zdharma-continuum/fast-syntax-highlighting/issues/27
FAST_HIGHLIGHT[chroma-man]=

