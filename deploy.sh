#!/bin/bash

git add .
git commit -m "Deploying latest changes"
git push origin main

ghp-import -c cognician.dev -n -p -f _build/html

# echo -n "Waiting for the new deployment to kick off"
# for i in {1..5}; do
#   sleep 1
#   echo -n "."
# done

# echo -e "\nOpening the latest workflow in the browser."
# gh run list --branch gh-pages --limit 1 --json url --jq '.[0].url' | xargs xdg-open
