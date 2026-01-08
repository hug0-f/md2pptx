#!/usr/bin/env bash

info() { echo "[INFO] $*"; }
warn() { echo "[WARN] $*" >&2; }
error() { echo "[ERROR] $*" >&2; exit 1; }

verbose() {
  $VERBOSE && echo "[DEBUG] $*"
}

