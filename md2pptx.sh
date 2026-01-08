#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
LIB_DIR="$SCRIPT_DIR/lib"

source "$LIB_DIR/logging.sh"
source "$LIB_DIR/checks.sh"
source "$LIB_DIR/install.sh"
source "$LIB_DIR/marp.sh"
source "$LIB_DIR/parallel.sh"
source "$LIB_DIR/ui.sh"
source "$LIB_DIR/themes.sh"

VERBOSE=false
DRY_RUN=false
CI=false
YES=false
NO_CLEANUP=false
SHOW_HELP=false
THEME=""
MARPOPTS=()
INPUTS=()
OUTPUT=""

INSTALLED_NODE=false
INSTALLED_NPM=false
INSTALLED_MARP=false

trap on_exit EXIT INT TERM

on_exit() {
  $SHOW_HELP && return
  cleanup
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    -v|--verbose) VERBOSE=true ;;
    --dry-run) DRY_RUN=true ;;
    --ci) CI=true ;;
    --yes) YES=true ;;
    --no-cleanup) NO_CLEANUP=true ;;
    --theme) THEME="$2"; shift ;;
    --marp-opt) MARPOPTS+=("$2"); shift ;;
    -o|--output) OUTPUT="$2"; shift ;;
    -h|--help)
      SHOW_HELP=true
      show_help
      exit 0
      ;;
    *) INPUTS+=("$1") ;;
  esac
  shift
done

[[ ${#INPUTS[@]} -eq 0 ]] && error "No input files provided"

check_dependencies
handle_installation

FILES=($(expand_inputs "${INPUTS[@]}"))

if [[ -n "$OUTPUT" && ${#FILES[@]} -ne 1 ]]; then
  error "--output can only be used with a single input file"
fi

TOTAL=${#FILES[@]}
[[ $TOTAL -eq 0 ]] && error "No valid markdown files found"

THEME=$(resolve_theme "$THEME")
MARPOPTS+=("--theme" "$THEME")

CPU=$(detect_cpu)
init_progress "$TOTAL"

process_files_parallel "$CPU" "${FILES[@]}"

summary

