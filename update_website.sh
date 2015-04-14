#!/usr/bin/env bash
MAIN_DIR=/Users/mwang/src/zone/61/log4analytics.com/mingderwang.github.io.source
SRC_DIR=/Users/mwang/src/zone/61/log4analytics.com/mingderwang.github.io.source/_site
DES_DIR=/Users/mwang/src/zone/61/log4analytics.com/mingderwang.github.io

jeykll build
echo '----------'
echo $SRC_DIR
echo '----------'
cd $MAIN_DIR
#bundle exec jekyll build
rsync -av --delete $SRC_DIR/* $DES_DIR 
cd $DES_DIR
git status 
git add -A 
echo '----------'
git status
git commit -m 'update contents'
git push
echo '----------'
echo $DES_DIR
echo '----------'
