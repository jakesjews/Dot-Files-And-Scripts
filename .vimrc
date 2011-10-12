set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'rails.vim'
Bundle 'taglist.vim'
Bundle 'The-NERD-tree'
Bundle 'vcscommand.vim'
Bundle 'project.tar.gz'
Bundle 'AutoComplPop' 
Bundle 'The-NERD-Commenter'
Bundle 'surround.vim'

"Language autocompletion
Bundle 'JSON.vim'
Bundle 'cocoa.vim'
Bundle 'scala.vim'
Bundle 'Erlang-plugin-package'
Bundle 'VimClojure'
Bundle 'haskell.vim'
Bundle 'checksyntax-B'
Bundle 'vim-coffee-script'
Bundle 'dbext.vim'
Bundle 'SQLComplete.vim'

set smartindent
set tabstop=2
set shiftwidth=2
set expandtab

set number

filetype plugin indent on
