#!/usr/bin/env bash

handle_installation() {
  if $CI; then
    [[ "$NEED_NODE" == true ]] && error "Node.js missing"
    [[ "$NEED_NPM" == true ]] && error "npm missing"
    [[ "$NEED_MARP" == true ]] && error "marp-cli missing"
    return
  fi

  install_if_missing
}

install_if_missing() {
  if [[ "$NEED_NODE" == true ]]; then
    info "Installing Node.js"
    sudo apt update
    sudo apt install -y nodejs
    INSTALLED_NODE=true
  fi

  if [[ "$NEED_NPM" == true ]]; then
    info "Installing npm"
    sudo apt install -y npm
    INSTALLED_NPM=true
  fi

  if [[ "$NEED_MARP" == true ]]; then
    info "Installing marp-cli"
    npm install -g @marp-team/marp-cli
    INSTALLED_MARP=true
  fi
}

cleanup() {
  $CI && return
  $NO_CLEANUP && return

  $INSTALLED_MARP && ask_remove "marp-cli" "npm uninstall -g @marp-team/marp-cli"
  $INSTALLED_NPM && ask_remove "npm" "sudo apt remove -y npm"
}

