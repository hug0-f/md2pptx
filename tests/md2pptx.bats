#!/usr/bin/env bats

setup() {
  mkdir -p tmp
  echo "# Test" > tmp/test.md
}

teardown() {
  rm -rf tmp
}

@test "help does not trigger cleanup" {
  run ./md2pptx --help
  [ "$status" -eq 0 ]
}

@test "dry-run works" {
  run ./md2pptx --dry-run tmp/test.md
  [ "$status" -eq 0 ]
}

@test "ci mode fails if marp missing" {
  PATH="/bin"
  run ./md2pptx --ci tmp/test.md
  [ "$status" -ne 0 ]
}

