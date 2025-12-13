#!/bin/sh

echo "Hitting /app1 and /app2 in parallel..."

for i in $(seq 1 1000); do
  curl -s http://localhost:1111/app1 > /dev/null &
  curl -s http://localhost:1111/app2 > /dev/null &
done

wait
echo "Done...."