#!/bin/bash

chmod +x ./build.sh
./build.sh

echo "Opening the built book in the browser."
xdg-open file:///home/ianad/repo/book/_build/html/index.html
