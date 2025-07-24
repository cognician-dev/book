#!/bin/bash

git add .
git commit -m "Deploying latest changes"
git push origin main

ghp-import -c cognician.dev -n -p -f _build/html

xdg-open "$(git remote get-url origin | sed -E 's#(git@|https://)([^:/]+)[:/]([^/]+)/([^.]+)(\.git)?#https://\2/\3/\4/actions#')"
