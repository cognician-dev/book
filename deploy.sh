#!/bin/bash

echo "Deploying the latest changes to the remote repository..."

git add .
git commit -m "Deploying latest changes"
git push origin main

ghp-import -c cognician.dev -n -p -f _build/html

