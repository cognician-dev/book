#!/bin/bash

git add .
git commit -m "Deploying latest changes"
git push origin main

ghp-import -c cognician.dev -n -p -f _build/html

sleep 1
echo "Waiting a moment for the deployment to kick off..."

# Open the GitHub Actions page for the repository
xdg-open "$(git remote get-url origin | sed -E 's#(git@|https://)([^:/]+)[:/]([^/]+)/([^.]+)(\.git)?#https://\2/\3/\4/actions#')"
# gh repo view --branch gh-pages --web