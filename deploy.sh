#!/bin/bash

echo "Deploying the latest changes to the remote repository..."
set -x
git add .
git commit -m "Deploying latest changes"
git push origin main

ghp-import -c cognician.dev -n -p -f _build/html
set +x

echo -n "Waiting for the new deployment run to appear"
for i in {1..5}; do
  sleep 1
  echo -n "."
done
echo  # move to a new line afterward
gh run list --branch gh-pages --limit 1 --json url --jq '.[0].url' | xargs xdg-open
