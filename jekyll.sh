#!/bin/sh
dir=`pwd`
site=/tmp/m2e
rm -rf ${site}
java -jar $dir/jekyll.jar -d ${site} serve
