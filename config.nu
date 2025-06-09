$env.config.show_banner = false
$env.config.buffer_editor = "nvim"

const HOMEBREW_PREFIX = '/opt/homebrew/'

alias nu-open = open
alias open = ^open
alias stree = /opt/homebrew/bin/stree
alias arc = ~/.arc/arc.sh
alias q = rlwrap --remember ~/.q/m64/q
alias factor = /Applications/factor/factor
alias l = ls
alias vps = ssh root@192.81.212.121
alias git-oops = git reset --soft HEAD~
alias vim = nvim
alias vi = nvim
alias git-graph = git commit-graph write --reachable --changed-paths
alias mongo = mongosh --quiet
alias bash = opt/homebrew/bin/bash
alias make = /opt/homebrew/opt/make/libexec/gnubin/make
alias rg-all = rg -uuu
alias cargo-binstall = cargo-binstall --no-confirm
alias UVtoolsCmd = /Applications/UVtools.app/Contents/MacOS/UVtoolsCmd
alias readme = glow README.md -p
alias smithery = npx @smithery/cli
alias mux = tmuxinator

def flush-cache [] { sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder }
def jenv-start [] { eval "$(jenv init -)" }

def count-instances [pattern: string] {
  rg $pattern --count
  | lines
  | split column ':' file count
  | sort-by count
  | rename file hits
}

def flac-to-mp3 [] {
  ls *.flac
  | each {|f|
       ffmpeg -i $f.name -qscale:a 0 ($f.name | str replace '.flac' '.mp3')
    }
  rm *.flac
}

def pwdx [pid:int] {
  lsof -a -d cwd -p $pid -n -Fn
  | lines
  | first
  | str substring 1..
}

def docker-clean [] {
  docker-sync-stack clean
  docker-compose down --volumes
  docker system prune --volumes --force
}

def gnuradio-companion [] {
  $env.PYTHONPATH = $"($env.GR_PREFIX)/lib/python3.13/site-packages"
  $env.DYLD_LIBRARY_PATH = $"($env.GR_PREFIX)/lib"
  $env.PATH = ($env.PATH | prepend [$"($env.GR_PREFIX)/bin"])
  /opt/homebrew/bin/gnuradio-companion
}

def alphabetize_files [] {
  let chars = ((0..9 | each {|d| $d | into string}) ++ ('a'..'z'))

  for $c in $chars {
    ^mkdir $c --ignore-errors

    let hits = (
      ^ls --no-symlinks
      | where type == "file"
      | where { (str downcase $it.name) starts-with $c }
      | get name
    )

    if ($hits | is-empty) == false {
      mv $hits $c
    }
  }
}

def quartus_mister [] {
  docker run --platform linux/amd64 --rm -v $"(pwd):/build" -e DISPLAY=host.docker.internal:0 -v /tmp/.X11-unix:/tmp/.X11-unix jakesjews/quartus-mac-arm quartus
}

def quartus_mister_compile [project] {
  docker run --platform linux/amd64 -it --rm -v $"(pwd):/build" jakesjews/quartus-mac-arm quartus_sh --flow compile $project
}

def quartus_pocket [] {
  docker run --platform linux/amd64 --rm -v $"(pwd):/build" -e DISPLAY=host.docker.internal:0 -v /tmp/.X11-unix:/tmp/.X11-unix didiermalenfant/quartus:22.1-apple-silicon quartus
}

def quartus_pocket_compile [project] {
  docker run --platform linux/amd64 -it --rm -v $"(pwd):/build" didiermalenfant/quartus:22.1-apple-silicon quartus_sh --flow compile $project
}

def reverse_bitstream [file] {
  perl -p -0777 -e '$_=~s/(.)/chr(((ord($1)*8623620610) & 1136090292240)%1023)/egs' $file | save bitstream.rbf_r
}

def restore_history [] {
  sqlite3 $"($env.HOME)/Library/Application Support/McFly/history.db" 'select ": " || id || ":0;" || cmd from commands order by id;' | save $"($env.HOME)/.zsh_history"
}

def update-pg-modeler [] {
  qmake -r pgmodeler.pro -early $"QMAKE_DEFAULT_LIBDIRS=$(xcrun -show-sdk-path)/usr/lib"
  make -j8
  make install
}

def update [] {
  def _section [title] { print (('#' | repeat 3 | str join) ++ ' ' ++ $title) }

  _section 'homebrew'
  brew update
  brew upgrade --greedy-auto-updates

  _section 'vim plugins'
  nvim --headless '+Lazy! sync | +TSUpdateSync | +MasonToolsUpdateSync | +qa'

  # ... (all the other segments from your zsh `update` remain 2-to-1)
  _section 'brew cleanup'
  brew autoremove; brew cleanup -s; brew tap --repair; rm -rf (brew --cache)
}

zoxide init nushell --cmd j | save -f ~/.zoxide.nu
source ~/.zoxide.nu 

