#!/bin/sh
set -e

bundle install
bundle exec rake assets:precompile

rm -f /app/tmp/pids/server.pid

chown ${CURRENT_UID} -Rh .

exec "$@"