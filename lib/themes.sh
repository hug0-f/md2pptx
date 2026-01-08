#!/usr/bin/env bash

discover_themes() {
  find . /usr/share/marp/themes -type f -name "*.css" 2>/dev/null | sort -u
}

resolve_theme() {
  local selected="$1"

  [[ -n "$selected" ]] && echo "$selected" && return

  mapfile -t THEMES < <(discover_themes)

  [[ ${#THEMES[@]} -eq 0 ]] && echo "default" && return

  if $CI; then
    basename "${THEMES[0]}"
    return
  fi

  choose_theme "${THEMES[@]}"
}

