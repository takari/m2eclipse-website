#!/bin/sh
dir=`pwd`
rm -rf ${site}
java -jar $dir/_tools/jekyll.jar serve
