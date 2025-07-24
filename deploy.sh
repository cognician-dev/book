#!/bin/bash

echo "Deploying the latest changes to the remote repository..."

git add .
set -x; git commit -m "Deploying latest changes"; set +x
git push origin main

ghp-import -c cognician.dev -n -p -f _build/html

echo -n "Waiting for the new deployment run to appear"
for i in {1..3}; do
  sleep 1
  echo -n "."
done
echo  # move to a new line afterward
gh run list --branch gh-pages --limit 1 --json url --jq '.[0].url' | xargs xdg-open
