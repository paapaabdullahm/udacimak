#!/usr/bin/env bash

isCommand() {
  for cmd in \
    "download" \
    "listnd" \
    "render" \
    "renderdir" \
    "settoken" \
    "login"
  do
    if [ -z "${cmd#"$1"}" ]; then
      return 0
    fi
  done

  return 1
}

# check if the first argument passed in looks like a flag
if [ "$(printf %c "$1")" = '-' ]; then
  set -- /tini -- udacimak "$@"

# check if the first argument passed in is udacimak
elif [ "$1" = 'udacimak' ]; then
  set -- /tini -- "$@"

# check if the first argument passed in matches a known command
elif isCommand "$1"; then
  set -- /tini -- udacimak "$@"
fi

exec "$@"
