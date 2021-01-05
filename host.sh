#!/bin/sh
ARCH=`uname -m`

# Map the CPU architecture to the hugo download
case $ARCH in
    x86_64)
        RET="64bit"
        ;;
    aarch64)
        RET="ARM64"
        ;;
    *)
        RET="Not supported"
        ;;
esac

echo $RET