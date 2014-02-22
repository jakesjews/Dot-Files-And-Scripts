#!/usr/bin/env zsh

npmls() {
    npm ls "$@" | grep "^[└├]" | sed "s/─┬/──/g"
}
 
