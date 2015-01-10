#!/bin/sh
dir=`pwd`
site=/Users/jvanzyl/dropbox/m2e
rm -rf ${site}
java -jar $dir/jekyll.jar -d ${site} serve
