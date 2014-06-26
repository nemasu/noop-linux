#!/bin/bash

for i in `find * -type d -prune`;
do
	pushd $i
	VERSION=`cat *.bld | grep -e "^VERSION=" | sed 's/VERSION=//g'`
	tar cJf ../$i-$VERSION.bldj *
	popd
done
