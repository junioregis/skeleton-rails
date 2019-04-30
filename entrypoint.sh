#!/bin/sh
set -e

bin/bundle install

rm -f /app/tmp/pids/server.pid

exec "$@"
