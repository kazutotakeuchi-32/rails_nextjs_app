#!/bin/bash
set -e


echo "Start entrypoint.prod.sh"

ls

echo "rm -f /app/tmp/pids/server.pid"
if [ -f /app/tmp/pids/server.pid ]; then
  rm /app/tmp/pids/server.pid
fi

echo "rails create db"
bundle exec rails db:create 

echo "rails migrate db"
bundle exec rails db:migrate 

echo "rails db seed"
bundle exec rails db:seed || true

echo "puma start"
bundle exec pumactl start



