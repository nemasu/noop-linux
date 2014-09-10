#!/bin/bash

for i in `ls -al | sed '/^d/!d' | awk '{print $9;}' | sed '/[\.][\.]*/d;'`;
do
	rm -rf /tmp/updateDeps.tmp
	rm -rf /tmp/updateDeps.tmp.new

	if [ -e "/var/noop/installed/$i" ];
	then

		sed -ne '/DEPS:/,/SIZE:/p;' /var/noop/installed/$i | sed '/DEPS:/d;/SIZE:/d;' > /tmp/updateDeps.tmp
		if [ `cat /tmp/updateDeps.tmp | wc -l` -gt 0 ];
		then
			echo -n "(" >> /tmp/updateDeps.tmp.new
			for j in `cat /tmp/updateDeps.tmp`;
			do
				echo -n "'$j' " >> /tmp/updateDeps.tmp.new
			done
			sed -i -e 's/ $//;' /tmp/updateDeps.tmp.new
			echo -n ")" >> /tmp/updateDeps.tmp.new

			sed -i -e 's/^DEPS=.*/DEPS='"`cat /tmp/updateDeps.tmp.new`"'/' $i/*.bld
		fi
	else
		echo $i does not exist.
	fi
done
