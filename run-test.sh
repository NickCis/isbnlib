#!/bin/bash
set -e

rm -f /tmp/flasklog.log

function test_case {
  ./app.py &>> /tmp/flasklog.log &
  sleep 1
  for i in {1..1000}; do curl -s http://localhost:5000 >/dev/null && curl -s http://localhost:5000/static/tux.png >/dev/null;done
  ps aux | grep "app.py"
  kill $(ps aux | egrep '.*py.*app.py$' | awk '{ print $2 }')
}

for i in $(seq 1 3); do
  echo "Run number ${i}"
  test_case
done

# check log to see if there are errors 
[[ -z $(grep "Errno 11" /tmp/flasklog.log) ]] && exit 0
exit 1
