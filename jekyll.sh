#!/bin/sh
dir=`pwd`
rm -rf ${site}
java -jar $dir/tools/jekyll.jar serve
