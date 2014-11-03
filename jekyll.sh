#!/bin/sh
dir=`pwd`
site=/tmp/site-m2e
java -jar $dir/jekyll.jar -d ${site} serve
