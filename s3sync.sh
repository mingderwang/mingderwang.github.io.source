#!/usr/bin/env bash
MAIN_DIR=/Users/mwang/src/zone/61/log4analytics.com/mingderwang.github.io.source
SRC_DIR=/Users/mwang/src/zone/61/log4analytics.com/mingderwang.github.io.source/_site
DES_DIR=/Users/mwang/src/zone/61/log4analytics.com/www-log4analytics-com

jekyll build
echo '----------'
echo $SRC_DIR
echo '----------'
cd $MAIN_DIR
#bundle exec jekyll build
rm -r $DES_DIR
mkdir $DES_DIR
rcp -r $SRC_DIR/* $DES_DIR
cd $DES_DIR
rm *.sh
s3cmd sync . s3://www.log4analytics.com
s3cmd sync . s3://log4analytics.com
