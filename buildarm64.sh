#!/bin/bash 

version=4.3

builddir=/tmp/skychart  # Be sure this is set to a non existent directory, it is removed after the run!

arch=$(arch)

if [[ $arch != "aarch64" ]]; then
  echo "wrong architecture"
  exit 1
fi

# adjuste here the target you want to crossbuild
# You MUST crosscompile Freepascal and Lazarus for this targets! 

unset extratarget

make_linuxarm=1
unset make_linuxarm_debug

if [[ -n $1 ]]; then
  configopt="fpc=$1"
fi
if [[ -n $2 ]]; then
  configopt=$configopt" lazarus=$2"
fi

save_PATH=$PATH
wd=`pwd`

# check if new revision since last run
read lastrev <last.build
currentrev=$(git rev-list --count --first-parent HEAD)
if [[ -z $currentrev ]]; then 
 currentrev=$(grep RevisionStr skychart/revision.inc| sed "s/const RevisionStr = '//"| sed "s/';//")
fi
echo $lastrev ' - ' $currentrev
if [[ $lastrev -ne $currentrev ]]; then

# delete old files
  rm skychart_*_arm64.deb
  rm skychart-*_arm64.tar.bz2
  rm -rf $builddir

# make Linux arm version
if [[ $make_linuxarm ]]; then
  ./configure $configopt prefix=$builddir target=aarch64-linux$extratarget
  if [[ $? -ne 0 ]]; then exit 1;fi
  make CPU_TARGET=aarch64 OS_TARGET=linux clean
  make CPU_TARGET=aarch64 OS_TARGET=linux
  if [[ $? -ne 0 ]]; then exit 1;fi
  make install
  if [[ $? -ne 0 ]]; then exit 1;fi
  make install_data
  if [[ $? -ne 0 ]]; then exit 1;fi
  make install_doc
  if [[ $? -ne 0 ]]; then exit 1;fi
  make install_nonfree
  if [[ $? -ne 0 ]]; then exit 1;fi
  # tar
  cd $builddir
  cd ..
  tar cvjf skychart-$version-${currentrev}_linux_arm64.tar.bz2 skychart
  if [[ $? -ne 0 ]]; then exit 1;fi
  mv skychart*.tar.bz2 $wd
  if [[ $? -ne 0 ]]; then exit 1;fi
  # deb
  cd $wd
  rsync -a --exclude=.svn system_integration/Linux/debian $builddir
  cd $builddir
  mkdir debian/skychartarm64/usr/
  mv bin debian/skychartarm64/usr/
  mv share debian/skychartarm64/usr/
  cd debian
  sed -i "/Version:/ s/3/$version-$currentrev/" skychartarm64/DEBIAN/control
  fakeroot dpkg-deb --build skychartarm64 .
  if [[ $? -ne 0 ]]; then exit 1;fi
  mv skychart*.deb $wd
  if [[ $? -ne 0 ]]; then exit 1;fi
  cd $wd
  rm -rf $builddir
  if [[ $make_linuxarm_debug ]]; then
    make CPU_TARGET=aarch64 OS_TARGET=linux clean
    fpcopts="-O1 -g -gl -Ci -Co -Ct" make CPU_TARGET=aarch64 OS_TARGET=linux
    if [[ $? -ne 0 ]]; then exit 1;fi
    mkdir $builddir
    mkdir $builddir/debug
    cp skychart/cdc $builddir/debug/skychart
    cp skychart/cdcicon $builddir/debug/
    cp varobs/varobs $builddir/debug/
    cp varobs/varobs_lpv_bulletin $builddir/debug/
    cd $builddir
    tar cvjf bin-linux_arm64-debug-$currentrev.tar.bz2 debug
    if [[ $? -ne 0 ]]; then exit 1;fi
    mv bin-*.tar.bz2 $wd
    if [[ $? -ne 0 ]]; then exit 1;fi
    cd $wd
    rm -rf $builddir
  fi
fi

cd $wd
rm -rf $builddir

# store revision 
  echo $currentrev > last.build
else
  echo Already build at revision $currentrev
  exit 4
fi

