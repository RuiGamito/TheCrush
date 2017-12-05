CWD=$(cd "$(dirname "$0")"; pwd)
CWD="`dirname \"$0\"`"
echo $CWD
export JAVA_HOME="$CWD/tools/jdk-osx"
export ANT_HOME="$CWD/tools/ant"
export ANDROID_HOME="$CWD/tools/android-osx"
export PATH="$PATH:$ANT_HOME/bin:$JAVA_HOME"

cd "$CWD"


## make android ID and name unique so we can have multiple installs
# restore original manifest and src subdir
cp tools/love-android-sdl2/original/AndroidManifest.xml tools/love-android-sdl2/
rm -r tools/love-android-sdl2/src/love
cp -r tools/love-android-sdl2/original/love tools/love-android-sdl2/src/

# get date and hope no participants compile at the same second
datevar=`date +"%m%d%H%M%S"`

# replace id, name and src subdir
sed -i "" "s/loveToAndroid Game/Game $datevar/g" tools/love-android-sdl2/AndroidManifest.xml
sed -i "" "s/love.to.android/love\.to\.android$datevar/g" tools/love-android-sdl2/AndroidManifest.xml
sed -i "" "s/love.to.android/love\.to\.android$datevar/g" tools/love-android-sdl2/src/love/to/android/LtaActivity.java
mv tools/love-android-sdl2/src/love/to/android tools/love-android-sdl2/src/love/to/android$datevar

rm game.apk
pwd
cd "$CWD/tools/love-android-sdl2"
pwd
rm -r gen bin

cp ../../game.love assets/
cp ../../icon.png res/drawable-xxhdpi/ic_launcher.png

ant debug

cp bin/love_android_sdl2-debug.apk ../../game.apk

