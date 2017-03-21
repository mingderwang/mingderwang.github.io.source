#!/usr/bin/env bash
MAIN_DIR=/Users/mingderwang/2016/src/zone/mingderwang.github.io.source
#/Users/mingderwang/src/web/mingderwang.github.io.source
#/Users/mwang/src/zone/61/log4analytics.com/mingderwang.github.io.source
SRC_DIR=/Users/mingderwang/2016/src/zone/mingderwang.github.io.source/_site
#/Users/mwang/src/zone/61/log4analytics.com/mingderwang.github.io.source/_site
DES_DIR=/Users/mingderwang/2016/src/zone/www.log4analytics.com
#/USERS/MWANG/SRC/ZONE/61/LOG4ANALYTICS.COM/WWW-LOG4ANALYTICS-COM

bundle exec jekyll build
echo '----------'
echo $SRC_DIR
echo '----------'
cd $MAIN_DIR
#bundle exec jekyll build
rm -r $DES_DIR
mkdir $DES_DIR
cp -r $SRC_DIR/* $DES_DIR
cd $DES_DIR
rm *.sh
s3cmd sync . s3://www.log4analytics.com
s3cmd sync . s3://log4analytics.com
