#!/bin/sh
dir=`pwd`
site=${dir}/_site
java -jar $dir/jekyll.jar -d ${site} serve
