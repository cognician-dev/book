#!/bin/bash

echo "Cleaning up previous builds..."
jb clean --all .
echo "Building the book..."
jb build .

