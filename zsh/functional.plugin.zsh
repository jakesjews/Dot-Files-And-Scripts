#!/usr/bin/env zsh

eachl() {
  typeset f="$1"; shift
  typeset x
  typeset result=0
  for x; each_ "$x" "$f" || result=$?
  return $result
}

each_() {
  eval "$2"
}

each() {
  typeset f="$1 \"\$1\""; shift
  eachl "$f" "$@"
}

# usage:
#
# $ baz() { print $1 | grep baz }
# $ filter baz titi bazaar biz
# bazaar
filter() {
  (($#<1)) && {
    {
      print -- "usage: filter func list"
      print 
      print -- "example:"
      print -- '    > baz(){print "$*" | grep baz}'
      print -- '    > filter baz titi bazaar biz'
      print -- '    bazaar'
    } >&2
    return 1
  }
  typeset f="$1 \"\$1\""; shift
  filterl "$f" "$@"
}

filterl() {
  typeset f="$1"; shift
  typeset x
  for x; filter_ "$x" "$f"
  return 0
}

filter_() {
  eval "$2" && print -- "$1"
}

### filtera ArithRelation Arg ...  # is shorthand for
### filter '(( ArithRelation ))' Arg ...

filtera() {
  typeset f="(( $1 ))"; shift
  filterl "$f" "$@"
}

#fold () {
  #if (($#<2)) {
    #{
    #print -- 'usage: fold function list'
    #print 
    #print -- 'example:'
    #print -- '    > bar() { print $(($1 + $2)) }' 
    #print -- '    > fold bar 0 1 2 3 4 5' 
    #print -- '    15'
    #} >&2
    #return 1
  #} else {
    #typeset f="\$($1 \$acc \$1)"; shift
    #foldlp "$f" "$@"
  #}
#}

foldl () {
  if (($#<2)) {
    {
    print -- 'Warning, l is not for left! Its for lambda style expression!'
    print -- 'Though this is left fold still :)'
    } >&2
    return 1
  } else {
    local body=$1
    local acc=$2
    shift 2
    for x; acc=$(folde_ $x $acc $body)
    print -- $acc
    return 0
  }
}

folda () {
  typeset f="\$[ $1 ]"; shift
  foldlp "$f" "$@"
}

foldlp () {
  if (($#<2)) {
    {
    print -- 'Warning, l is not for left! Its for lambda style expression!'
    print -- 'Though this is left fold still :)'
    } >&2
    return 1
  } else {
    local body=$1
    local acc=$2
    shift 2
    for x; acc=$(fold_ $x $acc $body)
    print -- $acc
    return 0
  }
}

fold_ () {
  local acc=$2
  local body=$3
  print "${(e)body}"
}

folde_ () {
  local acc=$2
  local body=$3
  eval "${(e)body}"
}

map() {
  (($#<1)) && {
    print -- "usage: map funcname [list]"
    print
    print -- 'example:'
    print -- '    > foo(){print "x: $1"}'
    print -- '    > map foo a b c d'
    print -- '    x: a'
    print -- '    x: b'
    print -- '    x: c'
    print -- '    x: d'
    return 1
  }
  local func_name=$1
  shift
  for elem in $@; print -- $(eval $func_name $elem)
}

mapl () {
  (($#<1)) && {
    print -- "usage: mapl lambda-function [list]"
    print
    print -- 'example:'
    print -- "    > mapl 'echo \"x: \$1\"' a b c d"
    print -- '    x: a'
    print -- '    x: b'
    print -- '    x: c'
    print -- '    x: d'
    return 1
  }
  typeset f="$1"; shift
  typeset x
  typeset result=0
  for x; mapl_ "$x" "$f" || result=$?
  return $result
}
mapl_ () {
  eval "${(e)2}"
}


mapa () {
  (($#<1)) && {
    print -- "usage: mapa lambda-arithmetic [list]"
    print -- "       (shorthand for mapl '$[ f ]' [list])"
    print
    print -- 'example:'
    print -- "    > mapa '\$1+5' {1..3}"
    print -- '    6'
    print -- '    7'
    print -- '    8'
    return 1
  }
  typeset f="\$[ $1 ]"; shift
  mapa__ "$f" "$@"
}

mapa__ () {
  (($#<1)) && return 1
  typeset f="$1"; shift
  typeset x
  typeset result=0
  for x; mapa_ "$x" "$f" || result=$?
  return $result
}

mapa_ () {
  print -- "${(e)2}"
}
