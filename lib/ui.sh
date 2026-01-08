#!/usr/bin/env bash

ask() {
  $YES && return 0
  read -rp "$1 [y/N]: " r
  [[ "$r" =~ ^[Yy]$ ]]
}

ask_remove() {
  ask "Remove $1?" && eval "$2" || true
}

init_progress() {
  TOTAL="$1"
  echo "Processing $TOTAL files"
}

summary() {
  echo
  info "Completed"
  info "Success: $SUCCESS"
  info "Failed: $FAIL"

  if $INSTALLED_MARP || $INSTALLED_NPM || $INSTALLED_NODE; then
    info "Installed by md2pptx:"
    $INSTALLED_NODE && echo " - Node.js"
    $INSTALLED_NPM && echo " - npm"
    $INSTALLED_MARP && echo " - marp-cli"
  fi
}

show_help() {
  cat <<EOF
md2pptx [options] <file|dir>...

Options:
  -v, --verbose
  --dry-run
  --ci
  --yes
  --no-cleanup
  --theme <name>
  --marp-opt "<option>"
  -h, --help
EOF
}

