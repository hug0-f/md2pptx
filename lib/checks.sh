#!/usr/bin/env bash

check_command() {
  command -v "$1" >/dev/null 2>&1
}

check_dependencies() {
  NEED_NODE=false
  NEED_NPM=false
  NEED_MARP=false

  if check_command node; then
    verbose "Node.js found"
  else
    NEED_NODE=true
  fi

  if check_command npm; then
    verbose "npm found"
  else
    NEED_NPM=true
  fi

  if check_command marp; then
    verbose "marp-cli found"
  else
    NEED_MARP=true
  fi
}

detect_cpu() {
  nproc
}

expand_inputs() {
  for i in "$@"; do
    if [[ -d "$i" ]]; then
      find "$i" -type f -name "*.md"
    elif [[ -f "$i" ]]; then
      echo "$i"
    fi
  done
}

