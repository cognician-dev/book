#!/bin/bash

echo "Deploying the latest changes to the remote repository..."

git add .
git commit -m "Deploying latest changes"
git push origin main

# Extract repo identifier (e.g. user/repo)
REPO_URL=$(git remote get-url origin)
REPO=$(echo "$REPO_URL" | sed -E 's#(git@|https://)([^:/]+)[:/]([^/]+/[^.]+)(\.git)?#\3#')

# GitHub API setup
GITHUB_TOKEN=${GITHUB_TOKEN:-}
API_URL="https://api.github.com/repos/$REPO/actions/runs"
AUTH_HEADER=""
if [ -n "$GITHUB_TOKEN" ]; then
  AUTH_HEADER="Authorization: token $GITHUB_TOKEN"
  echo $AUTH_HEADER
fi

# Get the latest run ID before deployment
BASE_RUN_ID=$(curl -s -H "$AUTH_HEADER" "$API_URL" | jq '.workflow_runs[0].id')

echo "Latest pre-deploy run ID: $BASE_RUN_ID"

# Deploy the site
ghp-import -c cognician.dev -n -p -f _build/html

echo "Waiting for the new deployment run to appear..."

# Poll until a new run is detected
NEW_RUN_ID="$BASE_RUN_ID"
while [ "$NEW_RUN_ID" == "$BASE_RUN_ID" ] || [ "$NEW_RUN_ID" == "null" ]; do
  sleep 3
  NEW_RUN_ID=$(curl -s -H "$AUTH_HEADER" "$API_URL" | jq '.workflow_runs[0].id')
  echo "Current run ID: $NEW_RUN_ID"
done

# Fetch and open the new run's URL
LATEST_RUN_URL=$(curl -s -H "$AUTH_HEADER" "$API_URL" | jq -r '.workflow_runs[0].html_url')

if [ "$LATEST_RUN_URL" != "null" ]; then
  echo "New workflow run detected: $NEW_RUN_ID"
  echo "Opening: $LATEST_RUN_URL"
  xdg-open "$LATEST_RUN_URL"  # or `open` on macOS
else
  echo "❌ No new workflow run found."
fi
