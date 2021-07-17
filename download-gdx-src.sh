#!/bin/bash
set -e
BASE=$(cd $(dirname $0); pwd -P)

JAVADIR=$BASE/src/main/java

rm -rf $JAVADIR
mkdir -p $JAVADIR

BUILD_DIR=$BASE/jni/maven/target/libgdx

rm -rf $BUILD_DIR
mkdir -p $BUILD_DIR

cd $BUILD_DIR

#The root files still get fetched
git clone --depth 1 --filter=blob:none --sparse https://github.com/libgdx/libgdx
cd libgdx
git sparse-checkout set gdx/src/

cd $JAVADIR
#Make symbolic link in the src folder so jnigen can find them
ln -s $BUILD_DIR/libgdx/gdx/src/com/ .