#!/bin/bash

destdir=$1

if [ -z "$destdir" ]; then
   export destdir=/tmp/skychart
fi

echo Install skychart to $destdir

install -d -m 755 $destdir
install -d -m 755 $destdir/skychart.app
install -d -m 755 $destdir/skychart.app/Contents
install -d -m 755 $destdir/skychart.app/Contents/MacOS
install -d -m 755 $destdir/skychart.app/Contents/Resources
install -d -m 755 $destdir/skychart.app/Contents/Frameworks
install -v -m 644 system_integration/MacOSX/pkg/skychart.app/Contents/Info.plist $destdir/skychart.app/Contents/
install -v -m 644 system_integration/MacOSX/pkg/skychart.app/Contents/PkgInfo $destdir/skychart.app/Contents/
install -v -m 755 -s skychart/cdc  $destdir/skychart.app/Contents/MacOS/skychart
install -v -m 644 system_integration/MacOSX/pkg/skychart.app/Contents/Resources/README.rtf $destdir/skychart.app/Contents/Resources/
install -v -m 644 system_integration/MacOSX/pkg/skychart.app/Contents/Resources/cdcIcon2.icns $destdir/skychart.app/Contents/Resources/
if [ $CPU_TARGET = aarch64 ]; then
  tar xvzf system_integration/MacOSX/data/openssl-mac-arm64.tgz -C $destdir/skychart.app/Contents/Frameworks/
else
  tar xvzf system_integration/MacOSX/data/openssl-mac.tgz -C $destdir/skychart.app/Contents/Frameworks/
fi
install -d -m 755 $destdir/varobs.app
install -d -m 755 $destdir/varobs.app/Contents
install -d -m 755 $destdir/varobs.app/Contents/MacOS
install -d -m 755 $destdir/varobs.app/Contents/Resources
install -v -m 644 system_integration/MacOSX/pkg/varobs.app/Contents/Info.plist $destdir/varobs.app/Contents/
install -v -m 644 system_integration/MacOSX/pkg/varobs.app/Contents/PkgInfo $destdir/varobs.app/Contents/
install -v -m 755 -s varobs/varobs  $destdir/varobs.app/Contents/MacOS/varobs
install -v -m 644 system_integration/MacOSX/pkg/varobs.app/Contents/Resources/README.rtf $destdir/varobs.app/Contents/Resources/
install -v -m 644 system_integration/MacOSX/pkg/varobs.app/Contents/Resources/varobs.icns $destdir/varobs.app/Contents/Resources/

install -v -m 755 skychart/library/getdss/libgetdss.dylib  $destdir/libgetdss.dylib
install -v -m 755 skychart/library/plan404/libplan404.dylib  $destdir/libplan404.dylib
install -v -m 755 skychart/library/wcs/libcdcwcs.dylib  $destdir/libcdcwcs.dylib
install -v -m 755 skychart/library/chealpix/libchealpix.dylib  $destdir/libchealpix.dylib
install -v -m 755 skychart/library/calceph/libcalceph.dylib  $destdir/libcalceph.dylib

install -d -m 755 $destdir/data
install -d -m 755 $destdir/data/planet
if [ $CPU_TARGET = aarch64 ]; then
  tar xvzf system_integration/MacOSX/data/xplanet-mac-arm64.tgz -C $destdir/data/planet/
else
  tar xvzf system_integration/MacOSX/data/xplanet-mac.tgz -C $destdir/data/planet/
fi

