#!/bin/bash

jb clean --all .
jb build .

git add .
open file:///home/ianad/repo/book/_build/html/index.html