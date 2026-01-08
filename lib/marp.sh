#!/usr/bin/env bash

convert_file() {
  local md="$1"
  local pptx

  if [[ -n "$OUTPUT" ]]; then
    pptx="$OUTPUT"
  else
    pptx="${md%.md}.pptx"
  fi

  verbose "Converting $md -> $pptx"

  $DRY_RUN && return 0

  marp "$md" --pptx -o "$pptx" "${MARPOPTS[@]}"

  [[ -f "$pptx" ]] || return 1
}

