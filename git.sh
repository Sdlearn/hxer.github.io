#!/bin/bash

# git with wiki branch
git add *
git commit -m "content"
git push origin wiki

# git with master branch
cd output
git add *
git commit -m "wiki"
git push origin master
