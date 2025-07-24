#!/bin/bash

chmod +x build.sh deploy.sh

./build.sh
./deploy.sh

echo "Waiting a moment for the deployment to kick off..."
sleep 1
echo "Opening GitHub Actions."
xdg-open "$(git remote get-url origin | sed -E 's#(git@|https://)([^:/]+)[:/]([^/]+)/([^.]+)(\.git)?#https://\2/\3/\4/actions#')"

# gh repo view --branch gh-pages --web
