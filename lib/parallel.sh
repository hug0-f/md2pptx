#!/usr/bin/env bash

SUCCESS=0
FAIL=0
COUNT=0
PIDS=()

process_files_parallel() {
  local jobs="$1"
  shift

  for md in "$@"; do
    (
      convert_file "$md"
    ) &
    PIDS+=($!)

    if [[ ${#PIDS[@]} -ge $jobs ]]; then
      wait -n || ((FAIL++))
      ((COUNT++))
      update_progress "$COUNT"
      PIDS=($(jobs -p))
    fi
  done

  for pid in "${PIDS[@]}"; do
    wait "$pid" || ((FAIL++))
    ((COUNT++))
    update_progress "$COUNT"
  done

  SUCCESS=$((TOTAL - FAIL))
}

