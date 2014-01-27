all:
	gcc -O2 -static trunc.c -o trunc

clean:
	rm -f trunc

install:
	mkdir -p ${DESTDIR}/usr/bin
	install -m755 trunc ${DESTDIR}/usr/bin
