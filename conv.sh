#!/bin/bash

SRC=$(realpath $(cd -P "$(dirname "${BASH_SOURCE[0]}")" && pwd))

set -e

pushd $SRC &> /dev/null

MODELS=$(find ./ -mindepth 1 -maxdepth 1 -type d -name [A-Z]\*|sed -e 's/^\.\///g')
for i in $MODELS; do
  echo "PROCESSING: $i"
  MODEL=$i/source/$i.fbx
  if [ ! -e $MODEL ]; then
    continue
  fi
  OUT=$i/conv
  rm -rf $OUT
  mkdir -p $OUT
  osgconv $MODEL $OUT/$i.binary.fbx
  osgconv -O FBX-ASCII $MODEL $OUT/$i.text.fbx
  osgconv $MODEL $OUT/$i.osgjs
done

rm -rf */*/*.fbm

popd &> /dev/null
