#!/bin/sh
set -e

bundle install

rm -f /app/tmp/pids/server.pid

exec "$@"