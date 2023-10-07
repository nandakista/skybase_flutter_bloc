source trap_ctrlc.sh

# build_apk
#   ENV             : staging|production
#   BUILD_NAME      : (example 1.0.0)
#   BUILD_NUMBER    : (example 1)
#   MODE            : [obfuscate]
declare ENV=$1
declare BUILD_NAME=$2
declare BUILD_NUMBER=$3
declare MODE=$4

declare APP_NAME="skybase-getx"

# validate mode
if [ ! "$MODE" == "obfuscate" ]
then
    MODE=
fi

# flutter build
echo "🟦 Starting Flutter build..."
echo "⬜️ Platform     : Android"
echo "⬜️ Env          : $ENV"
echo "⬜️ Build name   : $BUILD_NAME"
echo "⬜️ Build number : $BUILD_NUMBER"
echo "⬜️ Mode         : $MODE"
if [ "$MODE" == "obfuscate" ]
then
    flutter build apk -t "lib/main_$ENV.dart" --build-name="$BUILD_NAME" --build-number="$BUILD_NUMBER" --obfuscate --split-debug-info=.debug-info-android
else
    flutter build apk -t "lib/main_$ENV.dart" --build-name="$BUILD_NAME" --build-number="$BUILD_NUMBER"
fi

if [ ! $? == 0 ]
then
    echo "🟥 build failed"
    exit 1
fi

declare RLSDIR="build/app/outputs/flutter-apk"
declare APKNAME="$APP_NAME $BUILD_NAME ($BUILD_NUMBER) $ENV"

# make copies
cp "$RLSDIR/app-release.apk" "$RLSDIR/$APKNAME.apk"

echo "⬜️ Location: $RLSDIR/app-release.apk"
echo "⬜️ Or look for renamed file: \033[4m$APKNAME.apk\033[0m"
echo "🟩 Build done"
