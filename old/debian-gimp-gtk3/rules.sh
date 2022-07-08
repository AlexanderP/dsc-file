#!/bin/bash
set -e
sed "s/MYPAINT_BRUSHES_DIR/\"\/usr\/lib\/gimpgtk3\/share\/mypaint-data\/1.0\/brushes\"/g" -i app/config/gimpcoreconfig.c

NUMJOBS=${1}

export CURDIR=$(pwd)
export PREFIXDIR=${CURDIR}/debian/tmp2/usr/lib/gimpgtk3
export BABLOPT="--prefix=${PREFIXDIR} --wrap-mode=nodownload --buildtype=plain --libdir=lib"
export GEGLOPT="--prefix=${PREFIXDIR} --libdir=lib"
export MYPAINTOPT="--prefix=${PREFIXDIR}"
export GIMPOPT="--prefix=${PREFIXDIR} --disable-docs --with-python=force"
export PKG_CONFIG_PATH=${PREFIXDIR}/lib/pkgconfig:${PREFIXDIR}/share/pkgconfig:${PKG_CONFIG_PATH}
export PATH=${PREFIXDIR}/bin:${PATH}
export LD_RUN_PATH=${PREFIXDIR}/lib:${LD_RUN_PATH}
export LD_LIBRARY_PATH=${PREFIXDIR}/lib:${LD_LIBRARY_PATH}
export CC=gcc
export CXX=g++
export XDG_DATA_DIRS=${PREFIXDIR}/share:${XDG_DATA_DIRS}

#libmypaint = 1.3
	cd ${CURDIR}/3rdparty/libmypaint || exit 1
	./autogen.sh
	./configure ${MYPAINTOPT}
	make -j${NUMJOBS}
	make install
#mypaint-brushes = 1.3
	cd ${CURDIR}/3rdparty/mypaint-brushes || exit 1
	./autogen.sh
	./configure ${MYPAINTOPT}
	make -j${NUMJOBS}
	make install
#babl
	cd ${CURDIR}/3rdparty/babl || exit 1
	meson ${BABLOPT} build
	cd build || exit 1
	ninja -j${NUMJOBS}
	ninja install
#gegl
	cd ${CURDIR}/3rdparty/gegl || exit 1
	meson ${GEGLOPT} build
	meson configure -Dlibav=disabled -Ddocs=false build
	cd build || exit 1
	ninja -j${NUMJOBS}
	ninja install
#gimp
	cd ${CURDIR} || exit 1
	./autogen.sh ${GIMPOPT}
	make -j${NUMJOBS}
	make install
