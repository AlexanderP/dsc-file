#!/bin/bash

INSTALL_DIR="/usr/lib/gimpdevel"
export LD_LIBRARY_PATH="$INSTALL_DIR/lib:$LD_LIBRARY_PATH"
export PATH="${PATH}:$INSTALL_DIR/bin"
export GEGL_PATH="$INSTALL_DIR/lib/gegl-0.3"
export BABL_PATH="$INSTALL_DIR/lib/babl-0.1"
export GIMP2_DATADIR="$INSTALL_DIR/share/gimp/2.0"
export GIMP2_LOCALEDIR="$INSTALL_DIR/share/locale"
export GIMP2_PLUGINDIR="$INSTALL_DIR/lib/gimp/2.0"
export GIMP2_SYSCONFDIR="$INSTALL_DIR/etc/gimp/2.0"
$INSTALL_DIR/bin/gimp-2.10 "$@"
