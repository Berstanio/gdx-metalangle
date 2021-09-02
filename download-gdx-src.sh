#!/bin/bash
set -e
BASE=$(cd $(dirname $0); pwd -P)

export GPG_TTY=$(tty)

JAVADIR=$BASE/src/main/java

rm -rf $JAVADIR
mkdir -p $JAVADIR

BUILD_DIR=$BASE/jni/maven/target/libgdx

rm -rf $BUILD_DIR
mkdir -p $BUILD_DIR

cd $BUILD_DIR

#The root files still get fetched
git clone --depth 1 --filter=blob:none --sparse https://github.com/Berstanio/libgdx -b metalkit-bindings
cd libgdx
git sparse-checkout set gdx/src/
git sparse-checkout add backends/gdx-backend-robovm/
git sparse-checkout add backends/gdx-backend-moe/
git sparse-checkout add pom.xml

/bin/cp $BASE/poms/pom-base.xml pom.xml

cd backends/gdx-backend-robovm
# Maybe this can be reduced to a singe sed?
sed -i '' 's/gdx-backend-robovm/gdx-backend-robovm-metalangle/g' pom.xml
sed -i '' 's/project.groupId/parent.groupId/g' pom.xml
awk '/gdx-backend-robovm-metalangle/{print "  <groupId>io.github.berstanio</groupId>"}1' pom.xml > pom.tmp.xml && mv pom.tmp.xml pom.xml
mvn deploy
cd ..
cd gdx-backend-moe
sed -i '' 's/gdx-backend-moe/gdx-backend-moe-metalangle/g' pom.xml
sed -i '' 's/project.groupId/parent.groupId/g' pom.xml
awk '/gdx-backend-moe-metalangle/{print "  <groupId>io.github.berstanio</groupId>"}1' pom.xml > pom.tmp.xml && mv pom.tmp.xml pom.xml
mvn deploy

cd $JAVADIR
#Make symbolic link in the src folder so jnigen can find them
ln -s $BUILD_DIR/libgdx/gdx/src/com/ .