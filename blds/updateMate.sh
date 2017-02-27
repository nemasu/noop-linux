#!/usr/bin/bash

set -e

function bld_me() {
    tar cjf /tmp/bldme.bldj * && BLDR_DIST=1 pkgr -m /tmp/bldme.bldj && rm /tmp/bldme.bldj
}

function getPkgInfo() {
    grep "$1" /tmp/mate-releases | tail -n1
}

function getPkgVer() {
   getPkgInfo $1 | sed -e 's/.*-\([0-9\.]*\)\.tar\.xz/\1/g'
}

if [ ! -e /tmp/mate-releases ]; then
    curl -L -s http://pub.mate-desktop.org/releases/$1/ | sed -e 's/.*a href="//g;s/\.tar\.xz.*/.tar.xz/g' > /tmp/mate-releases
fi

for i in `cat /var/noop/blds/mate-order`; do
    file="/var/noop/blds/$i/${i}.bld"
    if [ ! -e $file ]; then
        echo "$i bld doesn't exist";
        exit 1
    fi
    ver=`getPkgVer $i`
    if [ -z "$ver" ]; then
        echo "$i doesn't exist in mate release (could be non-mate package)"
        continue;
    fi
    let dver=`grep "DVERSION" $file | wc -l`;
    if [ $dver -gt 0 ]; then
        sed -i -e 's/^DVERSION=.*/DVERSION='"$ver"'/;' $file
    fi
    sed -i -e 's/^VERSION=.*/VERSION='"$ver"'/;' $file
done

for i in `cat /var/noop/blds/mate-order`; do
    set +e
    let exists=`ls /root/bldr-done/${i}-* 2>/dev/null | wc -l`
    set -e
    if [ $exists -gt 0 ]; then
        echo "$i built, skipping..."
        continue;
    fi
    new_ver=`getPkgVer $i`
    old_ver=`pkgr --jsonmeta | jq -r .version`
    if [ "$new_ver" == "$old_ver" ]; then
        echo "$i is up to date, skipping..."
        continue;
    fi
    pushd /var/noop/blds/$i/
    bld_me
    popd
done
