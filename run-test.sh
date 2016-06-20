#!/bin/bash
set -e

rm -f /tmp/flasklog.log

function test_case {
  ./app.py &>> /tmp/flasklog.log &
  sleep 5
  for i in {1..100}
  do 
    curl -s http://localhost:5000 >/dev/null
    curl -s http://localhost:5000/static/tux.png >/dev/null
    curl -s http://localhost:5000/static/tux1.png >/dev/null
    curl -s http://localhost:5000/static/tux2.png >/dev/null
    touch app.py
  done
  kill $(ps aux | egrep '.*py.*app.py$' | awk '{ print $2 }')
}

for i in $(seq 1 3); do
  echo "Run number ${i}"
  test_case
done

# check log to see if there are errors 
[[ -z $(grep "Errno 11" /tmp/flasklog.log) ]] && exit 0
cat /tmp/flasklog.log
exit 1