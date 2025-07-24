#!/bin/bash

echo "Deploying the latest changes to the remote repository..."

git add .
git commit -m "Deploying latest changes"
git push origin main

ghp-import -c cognician.dev -n -p -f _build/html

echo "Waiting for the deployment to kick off..."
sleep 3

REPO_URL=$(git remote get-url origin)
REPO=$(echo "$REPO_URL" | sed -E 's#(git@|https://)([^:/]+)[:/]([^/]+/[^.]+)(\.git)?#\3#')

# Optional: set this to your GitHub token if accessing private repos
GITHUB_TOKEN=${GITHUB_TOKEN:-}

API_URL="https://api.github.com/repos/$REPO/actions/runs"

if [ -n "$GITHUB_TOKEN" ]; then
  AUTH_HEADER="Authorization: token $GITHUB_TOKEN"
else
  AUTH_HEADER=""
fi

LATEST_RUN_URL=$(curl -s -H "$AUTH_HEADER" "$API_URL" | jq -r '.workflow_runs[0].html_url')

if [ "$LATEST_RUN_URL" != "null" ]; then
  xdg-open "$LATEST_RUN_URL"  # or `open` on macOS
else
  echo "❌ No workflow runs found."
fi