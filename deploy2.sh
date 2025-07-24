#!/bin/bash

git add .
git commit -m "Deploying latest changes"
git push origin main

ghp-import -n -p -f _build/html