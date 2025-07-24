#!/bin/bash

echo "Cleaning up previous builds..."
jb clean --all .
echo "Building the book..."
jb build .

sleep 1
echo "Opening the built book in the browser."
xdg-open file:///home/ianad/repo/book/_build/html/index.html