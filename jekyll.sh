#!/bin/sh
dir=`pwd`
rm -rf ${site}
java -jar $dir/jekyll.jar serve
