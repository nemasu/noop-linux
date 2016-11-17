#!/usr/bin/bash

set -e

if [ -z "$1" ]; then
    echo "name, desc, ver, src, build, listurl"
    exit 1
fi

name="$1"
desc="$2"
ver="$3"
src="$4"
build="$5"
listurl="$6"
bld="${name}".bld

mkdir -p /var/noop/blds/"${name}"/
pushd  /var/noop/blds/"${name}"/
cp ../../etc/template-x.y.bld $bld

sed -i -e 's|NAME=|NAME='"${name}"'|' $bld
sed -i -e 's|DESC=|DESC="'"${desc}"'"|' $bld
sed -i -e 's|VERSION=|VERSION='"${ver}"'|' $bld
sed -i -e 's|SRC=|SRC='"${src}"'|' $bld
sed -i -e 's|BUILD=.*|BUILD='"${build}"'|' $bld
sed -i -e 's|LISTURL=|LISTURL='"${listurl}"'|' $bld

exit 0
