#!/bin/bash

APK_TOOL_DIR=./tools/StartGamedev-170112-osx
BUILD_APK=make-apk.command
FILES="*.lua parts.png catui font img audio"
LOVE_FILE=game.love
APK_FILE=game.apk

echo "Zipping the files..."
zip -r $LOVE_FILE $FILES
echo "  - created $LOVE_FILE"
mv $LOVE_FILE $APK_TOOL_DIR

echo
echo "Running packager..."
cd $APK_TOOL_DIR
open -g $BUILD_APK > /dev/null
sleep 30

if [ -f $APK_FILE ]; then
  echo "  - APK created"
else
  echo "  - APK creation FAILED"
  exit 1
fi

kill -9 $(cat PID)

echo "Installing APK..."
adb install $APK_FILE
