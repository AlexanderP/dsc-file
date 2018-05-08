#!/bin/bash

INSTALL_DIR="/usr/lib/gimpgtk3"
export LD_LIBRARY_PATH="$INSTALL_DIR/lib:$LD_LIBRARY_PATH"
export PATH="${PATH}:$INSTALL_DIR/bin"
export GEGL_PATH="$INSTALL_DIR/lib/gegl-0.4"
export BABL_PATH="$INSTALL_DIR/lib/babl-0.1"
export GIMP3_DATADIR="$INSTALL_DIR/share/gimp/3.0"
export GIMP3_LOCALEDIR="$INSTALL_DIR/share/locale"
export GIMP3_PLUGINDIR="$INSTALL_DIR/lib/gimp/3.0"
export GIMP3_SYSCONFDIR="$INSTALL_DIR/etc/gimp/3.0"
cd $INSTALL_DIR/bin
gimp-2.99 "$@"
